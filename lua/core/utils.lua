_G.doomnvim = {}
local stdpath = vim.fn.stdpath
local tbl_insert = table.insert

local supported_configs = {
  stdpath "config",
  stdpath "config" .. "/../doomnvim",
}

local function load_module_file(module)
  local found_module = nil
  for _, config_path in ipairs(supported_configs) do
    local module_path = config_path .. "/lua/" .. module:gsub("%.", "/") .. ".lua"
    if vim.fn.filereadable(module_path) == 1 then
      found_module = module_path
    end
  end
  if found_module then
    local status_ok, loaded_module = pcall(require, module)
    if status_ok then
      found_module = loaded_module
    else
      doomnvim.notify("Error loading " .. found_module, "error")
    end
  end
  return found_module
end

doomnvim.user_settings = load_module_file "user.init"
doomnvim.default_compile_path = stdpath "config" .. "/lua/packer_compiled.lua"
doomnvim.user_terminals = {}

local function func_or_extend(overrides, default, extend)
  if extend then
    if type(overrides) == "table" then
      default = vim.tbl_deep_extend("force", default, overrides)
    elseif type(overrides) == "function" then
      default = overrides(default)
    end
  elseif overrides ~= nil then
    default = overrides
  end
  return default
end

function doomnvim.conditional_func(func, condition, ...)
  if (condition == nil and true or condition) and type(func) == "function" then
    return func(...)
  end
end

function doomnvim.notify(msg, type, opts)
  vim.notify(msg, type, vim.tbl_deep_extend("force", { title = "DoomNvim" }, opts or {}))
end

local function user_setting_table(module)
  local settings = doomnvim.user_settings or {}
  for tbl in string.gmatch(module, "([^%.]+)") do
    settings = settings[tbl]
    if settings == nil then
      break
    end
  end
  return settings
end

function doomnvim.initialize_packer()
  local packer_avail, packer = pcall(require, "packer")
  if not packer_avail then
    local packer_path = stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    vim.fn.delete(packer_path, "rf")
    vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      packer_path,
    }
    doomnvim.echo { { "Initializing Packer...\n\n" } }
    vim.cmd "packadd packer.nvim"
    packer_avail, packer = pcall(require, "packer")
    if not packer_avail then
      vim.api.nvim_err_writeln("Failed to load packer at:" .. packer_path .. "\n\n" .. packer)
    end
  end
  return packer
end

function doomnvim.vim_opts(options)
  for scope, table in pairs(options) do
    for setting, value in pairs(table) do
      vim[scope][setting] = value
    end
  end
end

function doomnvim.user_plugin_opts(module, default, extend, prefix)
  if extend == nil then
    extend = true
  end
  default = default or {}
  local user_settings = load_module_file((prefix or "user") .. "." .. module)
  if user_settings == nil and prefix == nil then
    user_settings = user_setting_table(module)
  end
  if user_settings ~= nil then
    default = func_or_extend(user_settings, default, extend)
  end
  return default
end

function doomnvim.compiled()
  local run_me, _ = loadfile(
    doomnvim.user_plugin_opts("plugins.packer", { compile_path = doomnvim.default_compile_path }).compile_path
  )
  if run_me then
    run_me()
  else
    doomnvim.echo { { "Please run " }, { ":PackerSync", "Title" } }
  end
end

function doomnvim.url_opener()
  if vim.fn.has "mac" == 1 then
    vim.fn.jobstart({ "open", vim.fn.expand "<cfile>" }, { detach = true })
  elseif vim.fn.has "unix" == 1 then
    vim.fn.jobstart({ "xdg-open", vim.fn.expand "<cfile>" }, { detach = true })
  else
    doomnvim.notify("gx is not supported on this OS!", "error")
  end
end

-- term_details can be either a string for just a command or
-- a complete table to provide full access to configuration when calling Terminal:new()
function doomnvim.toggle_term_cmd(term_details)
  if type(term_details) == "string" then
    term_details = { cmd = term_details, hidden = true }
  end
  local term_key = term_details.cmd
  if vim.v.count > 0 and term_details.count == nil then
    term_details.count = vim.v.count
    term_key = term_key .. vim.v.count
  end
  if doomnvim.user_terminals[term_key] == nil then
    doomnvim.user_terminals[term_key] = require("toggleterm.terminal").Terminal:new(term_details)
  end
  doomnvim.user_terminals[term_key]:toggle()
end

function doomnvim.add_cmp_source(source)
  local cmp_avail, cmp = pcall(require, "cmp")
  if cmp_avail then
    local config = cmp.get_config()
    tbl_insert(config.sources, source)
    cmp.setup(config)
  end
end

function doomnvim.get_user_cmp_source(source)
  source = type(source) == "string" and { name = source } or source
  local priority = doomnvim.user_plugin_opts("cmp.source_priority", {
    nvim_lsp = 1000,
    luasnip = 750,
    buffer = 500,
    path = 250,
  })[source.name]
  if priority then
    source.priority = priority
  end
  return source
end

function doomnvim.add_user_cmp_source(source)
  doomnvim.add_cmp_source(doomnvim.get_user_cmp_source(source))
end

function doomnvim.null_ls_providers(filetype)
  local registered = {}
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if sources_avail then
    for _, source in ipairs(sources.get_available(filetype)) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        tbl_insert(registered[method], source.name)
      end
    end
  end
  return registered
end

function doomnvim.null_ls_sources(filetype, source)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return methods_avail and doomnvim.null_ls_providers(filetype)[methods.internal[source]] or {}
end

function doomnvim.alpha_button(sc, txt)
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
  if vim.g.mapleader then
    sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
  end
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

function doomnvim.is_available(plugin)
  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

function doomnvim.delete_url_match()
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == "HighlightURL" then
      vim.fn.matchdelete(match.id)
    end
  end
end

function doomnvim.set_url_match()
  doomnvim.delete_url_match()
  if vim.g.highlighturl_enabled then
    vim.fn.matchadd(
      "HighlightURL",
      "\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+",
      15
    )
  end
end

function doomnvim.toggle_url_match()
  vim.g.highlighturl_enabled = not vim.g.highlighturl_enabled
  doomnvim.set_url_match()
end

function doomnvim.update()
  (require "plenary.job")
    :new({
      command = "git",
      args = { "pull", "--ff-only" },
      cwd = stdpath "config",
      on_exit = function(_, return_val)
        if return_val == 0 then
          vim.notify("Updated!", "info", doomnvim.base_notification)
        else
          vim.notify("Update failed! Please try pulling manually.", "error", doomnvim.base_notification)
        end
      end,
    })
    :sync()
end

return doomnvim
