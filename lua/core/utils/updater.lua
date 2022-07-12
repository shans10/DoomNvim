local git = require "core.utils.git"
local options = doomnvim.user_plugin_opts(
  "updater",
  { remote = "origin", branch = "main", show_changelog = true }
)

doomnvim.updater = { options = options }

local function attempt_update()
  return git.pull(false)
end

local cancelled_message = { { "Update cancelled", "WarningMsg" } }

function doomnvim.updater.update()
  if not git.is_repo() then
    doomnvim.notify("Updater not available for non-git installations", "error")
    return
  end
  for remote, entry in pairs(options.remotes and options.remotes or {}) do
    local url = git.parse_remote_url(entry)
    local current_url = git.remote_url(remote, false)
    local check_needed = false
    if not current_url then
      git.remote_add(remote, url)
      check_needed = true
    elseif
      current_url ~= url
      and doomnvim.confirm_prompt {
        { "Remote " },
        { remote, "Title" },
        { " is currently set to " },
        { current_url, "WarningMsg" },
        { "\nWould you like us to set it to " },
        { url, "String" },
        { "?" },
      }
    then
      git.remote_update(remote, url)
      check_needed = true
    end
    if check_needed and git.remote_url(remote, false) ~= url then
      vim.api.nvim_err_writeln("Error setting up remote " .. remote .. " to " .. url)
      return
    end
  end
  if not git.fetch(options.remote) then
    vim.api.nvim_err_writeln("Error fetching remote: " .. options.remote)
    return
  end
  local local_branch = (options.remote == "origin" and "" or (options.remote .. "_")) .. options.branch
  if git.current_branch() ~= local_branch then
    doomnvim.echo {
      { "Switching to branch: " },
      { options.remote .. "/" .. options.branch .. "\n\n", "String" },
    }
    if not git.checkout(local_branch, false) then
      git.checkout("-b " .. local_branch .. " " .. options.remote .. "/" .. options.branch, false)
    end
  end
  if git.current_branch() ~= local_branch then
    vim.api.nvim_err_writeln("Error checking out branch: " .. options.remote .. "/" .. options.branch)
    return
  end
  local source = git.local_head() -- calculate current commit
  local target = git.remote_head(options.remote, options.branch)
  if not source or not target then -- continue if current and target commits were found
    vim.api.nvim_err_writeln "Error checking for updates"
    return
  elseif source == target then
    doomnvim.echo { { "No updates available", "String" } }
    return
  elseif -- prompt user if they want to accept update
    not options.skip_prompts
    and not doomnvim.confirm_prompt {
      { "Update available to ", "Title" },
      { target, "String" },
      { "\nContinue?" },
    }
  then
    doomnvim.echo(cancelled_message)
    return
  else -- perform update
    local changelog = git.get_commit_range(source, target)
    local breaking = git.breaking_changes(changelog)
    local breaking_prompt = { { "Update contains the following breaking changes:\n", "WarningMsg" } }
    vim.list_extend(breaking_prompt, git.pretty_changelog(breaking))
    vim.list_extend(breaking_prompt, { { "\nWould you like to continue?" } })
    if #breaking > 0 and not options.skip_prompts and not doomnvim.confirm_prompt(breaking_prompt) then
      doomnvim.echo(cancelled_message)
      return
    end
    local updated = attempt_update()
    if
      not updated
      and not options.skip_prompts
      and not doomnvim.confirm_prompt {
        { "Unable to pull due to local modifications to base files.\n", "ErrorMsg" },
        { "Reset local files and continue?" },
      }
    then
      doomnvim.echo(cancelled_message)
      return
    elseif not updated then
      git.hard_reset(source)
      updated = attempt_update()
    end
    if not updated then
      vim.api.nvim_err_writeln "Error ocurred performing update"
      return
    end
    local summary = {
      { "doomnvim updated successfully to ", "Title" },
      { git.current_version(), "String" },
      { "!\n", "Title" },
      { "Please restart and run :PackerSync.\n\n", "WarningMsg" },
    }
    if options.show_changelog and #changelog > 0 then
      vim.list_extend(summary, { { "Changelog:\n", "Title" } })
      vim.list_extend(summary, git.pretty_changelog(changelog))
    end
    doomnvim.echo(summary)
  end
end
