
local git = { url = "https://github.com/" }

function git.cmd(args, ...) return doomnvim.cmd("git -C " .. doomnvim.install.home .. " " .. args, ...) end

function git.is_repo() return git.cmd("rev-parse --is-inside-work-tree", false) end

function git.fetch(remote, ...) return git.cmd("fetch " .. remote, ...) end

function git.pull(...) return git.cmd("pull --rebase", ...) end

function git.checkout(dest, ...) return git.cmd("checkout " .. dest, ...) end

function git.hard_reset(dest, ...) return git.cmd("reset --hard " .. dest, ...) end

function git.remote_add(remote, url, ...) return git.cmd("remote add " .. remote .. " " .. url, ...) end

function git.remote_update(remote, url, ...) return git.cmd("remote set-url " .. remote .. " " .. url, ...) end

function git.remote_url(remote, ...) return doomnvim.trim_or_nil(git.cmd("remote get-url " .. remote, ...)) end

function git.current_version(...) return doomnvim.trim_or_nil(git.cmd("describe --always", ...)) end

function git.current_branch(...) return doomnvim.trim_or_nil(git.cmd("rev-parse --abbrev-ref HEAD", ...)) end

function git.local_head(...) return doomnvim.trim_or_nil(git.cmd("rev-parse HEAD", ...)) end

function git.remote_head(remote, branch, ...)
  return doomnvim.trim_or_nil(git.cmd("rev-list -n 1 " .. remote .. "/" .. branch, ...))
end

function git.parse_remote_url(str)
  return vim.fn.match(str, doomnvim.url_matcher) == -1
      and git.url .. str .. (vim.fn.match(str, "/") == -1 and "/doomnvim.git" or ".git")
    or str
end

return git
