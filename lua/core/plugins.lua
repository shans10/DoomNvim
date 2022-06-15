local doom_plugins = {
  -- Plugin manager
  ["wbthomason/packer.nvim"] = {},

  -- Optimiser
  ["lewis6991/impatient.nvim"] = {},

  -- Lua functions
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },

  -- Popup API
  ["nvim-lua/popup.nvim"] = {},

  -- Indent detection
  ["Darazaki/indent-o-matic"] = {
    event = "BufReadPost",
    config = function()
      require "configs.indent-o-matic"
    end,
  },

  -- Notification Enhancer
  ["rcarriga/nvim-notify"] = {
    event = "VimEnter",
    config = function()
      require "configs.notify"
    end,
  },

  -- Neovim UI Enhancer
  ["MunifTanjim/nui.nvim"] = { module = "nui" },

  -- Cursorhold fix
  ["antoinemadec/FixCursorHold.nvim"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  -- Smarter Splits
  ["mrjones2014/smart-splits.nvim"] = {
    module = "smart-splits",
    config = function()
      require "configs.smart-splits"
    end,
  },

  -- Icons
  ["kyazdani42/nvim-web-devicons"] = {
    event = "VimEnter",
    config = function()
      require "configs.icons"
    end,
  },

  -- Bufferline
  ["akinsho/bufferline.nvim"] = {
    after = "nvim-web-devicons",
    config = function()
      require "configs.bufferline"
    end,
  },

  -- Better buffer closing
  ["famiu/bufdelete.nvim"] = { cmd = { "Bdelete", "Bwipeout" } },

  -- File explorer
  ["kyazdani42/nvim-tree.lua"] = {
    -- commit = "20797a8d74e68bce50b98455c76c5de250c6f0e5",
    module = "nvim-tree",
    cmd = "NvimTree",
    config = function()
      require "configs.nvim-tree"
    end,
  },

  -- Statusline
  ["feline-nvim/feline.nvim"] = {
    after = "nvim-web-devicons",
    config = function()
      require "configs.feline"
    end,
  },

  -- Parenthesis highlighting
  ["p00f/nvim-ts-rainbow"] = { after = "nvim-treesitter" },

  -- Autoclose tags
  ["windwp/nvim-ts-autotag"] = { after = "nvim-treesitter" },

  -- Context based commenting
  ["JoosepAlviste/nvim-ts-context-commentstring"] = { after = "nvim-treesitter" },

  -- Syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    },
    config = function()
      require "configs.treesitter"
    end,
  },

  -- Snippet collection
  ["rafamadriz/friendly-snippets"] = { opt = true },

  -- Snippet engine
  ["L3MON4D3/LuaSnip"] = {
    module = "luasnip",
    wants = "friendly-snippets",
    config = function()
      require "configs.luasnip"
    end,
  },

  -- Completion engine
  ["hrsh7th/nvim-cmp"] = {
    event = "InsertEnter",
    config = function()
      require "configs.cmp"
    end,
  },

  -- Snippet completion source
  ["saadparwaiz1/cmp_luasnip"] = {
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_user_cmp_source "luasnip"
    end,
  },

  -- Buffer completion source
  ["hrsh7th/cmp-buffer"] = {
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_user_cmp_source "buffer"
    end,
  },

  -- Path completion source
  ["hrsh7th/cmp-path"] = {
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_user_cmp_source "path"
    end,
  },

  -- LSP completion source
  ["hrsh7th/cmp-nvim-lsp"] = {
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_user_cmp_source "nvim_lsp"
    end,
  },

  -- Built-in LSP
  ["neovim/nvim-lspconfig"] = { event = "VimEnter" },

  -- LSP manager
  ["williamboman/nvim-lsp-installer"] = {
    after = "nvim-lspconfig",
    config = function()
      require "configs.nvim-lsp-installer"
      require "configs.lsp"
    end,
  },

  -- LSP symbols
  ["stevearc/aerial.nvim"] = {
    module = "aerial",
    cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
    config = function()
      require "configs.aerial"
    end,
  },

  -- Formatting and linting
  ["jose-elias-alvarez/null-ls.nvim"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
      require "configs.null-ls"
    end,
  },

  -- Fuzzy finder
  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    module = "telescope",
    config = function()
      require "configs.telescope"
    end,
  },

  -- Fuzzy finder syntax support
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    after = "telescope.nvim",
    run = vim.fn.has "win32" == 1
        and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      or "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  -- Git integration
  ["lewis6991/gitsigns.nvim"] = {
    event = "BufEnter",
    config = function()
      require "configs.gitsigns"
    end,
  },

  -- Start screen
  ["goolord/alpha-nvim"] = {
    cmd = "Alpha",
    module = "alpha",
    config = function()
      require "configs.alpha"
    end,
  },

  -- Color highlighting
  ["norcalli/nvim-colorizer.lua"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
      require "configs.colorizer"
    end,
  },

  -- Autopairs
  ["windwp/nvim-autopairs"] = {
    event = "InsertEnter",
    config = function()
      require "configs.autopairs"
    end,
  },

  -- Terminal
  ["akinsho/nvim-toggleterm.lua"] = {
    cmd = "ToggleTerm",
    module = { "toggleterm", "toggleterm.terminal" },
    config = function()
      require "configs.toggleterm"
    end,
  },

  -- Commenting
  ["numToStr/Comment.nvim"] = {
    module = { "Comment", "Comment.api" },
    keys = { "gc", "gb", "g<", "g>" },
    config = function()
      require "configs.Comment"
    end,
  },

  -- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = {
    event = "BufRead",
    config = function()
      require "configs.indent-line"
    end,
  },

  -- Keymaps popup
  ["folke/which-key.nvim"] = {
    module = "which-key",
    config = function()
      require "configs.which-key"
    end,
  },

  -- Smooth scrolling
  ["declancm/cinnamon.nvim"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
      require "configs.cinnamon"
    end,
  },

  -- Smooth escaping
  ["max397574/better-escape.nvim"] = {
    event = "InsertCharPre",
    config = function()
      require "configs.better_escape"
    end,
  },

  -- Get extra JSON schemas
  ["b0o/SchemaStore.nvim"] = { module = "schemastore" },

  -- Session Manager
  ["Shatur/neovim-session-manager"] = {
    module = "session_manager",
    cmd = "SessionManager",
    event = "BufWritePost",
    config = function()
      require "configs.session_manager"
    end,
  },

  -- Remember last cursor position in file
  ["farmergreg/vim-lastplace"] = {},

  -- Projects
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup {}
    end
  },
}

local user_plugin_opts = doomnvim.user_plugin_opts
local packer = doomnvim.initialize_packer()
packer.startup {
  function(use)
    for key, plugin in pairs(user_plugin_opts("plugins.init", doom_plugins)) do
      if type(key) == "string" and not plugin[1] then
        plugin[1] = key
      end
      use(plugin)
    end
  end,
  config = user_plugin_opts("plugins.packer", {
    compile_path = doomnvim.default_compile_path,
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
      subcommands = {
        update = "pull --rebase",
      },
    },
    auto_clean = true,
    compile_on_sync = true,
  }),
}

doomnvim.compiled()
