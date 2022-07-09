local is_available = doomnvim.is_available

local maps = { n = {}, i = {}, v = {}, t = {}, [""] = {} }

-- Set space as leader key
maps[""]["<Space>"] = "<Nop>"

--- NORMAL MODE ---
--
-- Standard Operations
maps.n["<leader>."] = { "<cmd>cd %:p:h<cr>", desc = "Change CWD to focused file" }
maps.n["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "Clear search highlight" }
maps.n["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" }
maps.n["<leader>u"] = {
  function()
    doomnvim.toggle_url_match()
  end,
  desc = "Toggle URL Highlights",
}
maps.n["<leader>U"] = { "<cmd>exe \"edit\" stdpath(\"config\").\"/lua/user/init.lua\"<cr>", desc = "Load user configuration" }
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["gx"] = {
  function()
    doomnvim.url_opener()
  end,
  desc = "Open the file under cursor with system app",
}
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
maps.n["Q"] = "<Nop>"

-- Packer
maps.n["<leader>pc"] = { "<cmd>PackerCompile<cr>", desc = "Packer Compile" }
maps.n["<leader>pi"] = { "<cmd>PackerInstall<cr>", desc = "Packer Install" }
maps.n["<leader>ps"] = { "<cmd>PackerSync<cr>", desc = "Packer Sync" }
maps.n["<leader>pS"] = { "<cmd>PackerStatus<cr>", desc = "Packer Status" }
maps.n["<leader>pu"] = { "<cmd>PackerUpdate<cr>", desc = "Packer Update" }

-- LSP Installer
if is_available "nvim-lsp-installer" then
  maps.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
  maps.n["<leader>lI"] = { "<cmd>LspInstallInfo<cr>", desc = "LSP installer" }
end

-- File Standalone Keybindings
maps.n["<leader>fa"] = { "ggVG", desc = "Select all" }
maps.n["<leader>fi"] = { "gg=G", desc = "Indent all" }
maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["<leader>fp"] = { "1<C-g>", desc = "Show full path" }
maps.n["<leader>fr"] = { "<cmd>e<cr>", desc = "Refresh" }
maps.n["<leader>fR"] = { "<cmd>e!<cr>", desc = "Refresh unsaved" }
maps.n["<leader>fs"] = { "<cmd>w<cr>", desc = "Save" }
if is_available "suda.vim" then
  maps.n["<leader>fS"] = { "<cmd>SudaWrite<cr>", desc = "Save as root" }
end

-- Buffer Standalone Keybindings
maps.n["<leader>bn"] = { "<cmd>bn<cr>", desc = "Next buffer" }
maps.n["<leader>bp"] = { "<cmd>bp<cr>", desc = "Previous buffer" }

-- Bufdelete
if is_available "bufdelete.nvim" then
  maps.n["<leader>c"] = { "<cmd>Bdelete<cr>", desc = "Close buffer" }

  -- Buffer
  maps.n["<leader>bd"] = { "<cmd>Bdelete<cr>", desc = "Delete" }
  maps.n["<leader>bD"] = { "<cmd>Bdelete!<cr>", desc = "Delete unsaved" }

  -- File
  maps.n["<leader>fc"] = { "<cmd>Bdelete<cr>", desc = "Close" }
  maps.n["<leader>fC"] = { "<cmd>Bdelete!<cr>", desc = "Close unsaved" }

  -- Standalone(If bufdelete is not installed)
else
  maps.n["<leader>c"] = { "<cmd>bdelete<cr>", desc = "Close buffer" }

  -- Buffer
  maps.n["<leader>bd"] = { "<cmd>bdelete<cr>", desc = "Delete" }
  maps.n["<leader>bD"] = { "<cmd>bdelete!<cr>", desc = "Delete unsaved" }

  -- File
  maps.n["<leader>fc"] = { "<cmd>bdelete<cr>", desc = "Close" }
  maps.n["<leader>fC"] = { "<cmd>bdelete!<cr>", desc = "Close unsaved" }
end

-- NvimTree
if is_available "nvim-tree.lua" then
  maps.n["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" }
  maps.n["<leader>o"] = { "<cmd>NvimTreeFocus<cr>", desc = "Focus NvimTree" }
end

-- Alpha Dashboard
if is_available "alpha-nvim" then
  maps.n["<leader>d"] = { "<cmd>Alpha<cr>", desc = "Alpha Dashboard" }
end

-- Bufferline
if is_available "bufferline.nvim" then
  maps.n["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick and close buffer" }
  maps.n["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick and jump to buffer" }
  maps.n["<leader>bN"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" }
  maps.n["<leader>bP"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" }
end

-- Comment
if is_available "Comment.nvim" then
  maps.n["<leader>/"] = {
    function()
      require("Comment.api").toggle_current_linewise()
    end,
    desc = "Comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
    desc = "Toggle comment line",
  }
end

-- SymbolsOutline(Aerial)
if is_available "aerial.nvim" then
  maps.n["<leader>lS"] = { "<cmd>AerialToggle<cr>", desc = "Symbols outline" }
end

-- ToggleTerm
if is_available "toggleterm.nvim" then
  local toggle_term_cmd = doomnvim.toggle_term_cmd
  -- Git
  maps.n["<leader>gg"] = {
    function()
      toggle_term_cmd "lazygit"
    end,
    desc = "ToggleTerm lazygit",
  }

  -- Terminal
  maps.n["<leader>tl"] = {
    function()
      toggle_term_cmd "lazygit"
    end,
    desc = "ToggleTerm lazygit",
  }
  maps.n["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
  maps.n["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
  maps.n["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
  maps.n["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" }
end

-- SessionManager
if is_available "neovim-session-manager" then
  -- Session
  maps.n["<leader>Sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session from list" }
  maps.n["<leader>Sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
  maps.n["<leader>SL"] = { "<cmd>SessionManager! load_session<cr>", desc = "Load session from list" }
  maps.n["<leader>Ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save current session" }

  -- Search
  maps.n["<leader>ss"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
end

-- GitSigns
if is_available "gitsigns.nvim" then
  maps.n["<leader>gj"] = {
    function()
      require("gitsigns").next_hunk()
    end,
    desc = "Next git hunk",
  }
  maps.n["<leader>gk"] = {
    function()
      require("gitsigns").prev_hunk()
    end,
    desc = "Previous git hunk",
  }
  maps.n["<leader>gl"] = {
    function()
      require("gitsigns").blame_line()
    end,
    desc = "View git blame",
  }
  maps.n["<leader>gp"] = {
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview git hunk",
  }
  maps.n["<leader>gh"] = {
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset git hunk",
  }
  maps.n["<leader>gr"] = {
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset git buffer",
  }
  maps.n["<leader>gs"] = {
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Stage git hunk",
  }
  maps.n["<leader>gu"] = {
    function()
      require("gitsigns").undo_stage_hunk()
    end,
    desc = "Unstage git hunk",
  }
  maps.n["<leader>gd"] = {
    function()
      require("gitsigns").diffthis()
    end,
    desc = "View git diff",
  }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
  -- Better window navigation
  maps.n["<C-h>"] = {
    function()
      require("smart-splits").move_cursor_left()
    end,
    desc = "Move to left split",
  }
  maps.n["<C-j>"] = {
    function()
      require("smart-splits").move_cursor_down()
    end,
    desc = "Move to below split",
  }
  maps.n["<C-k>"] = {
    function()
      require("smart-splits").move_cursor_up()
    end,
    desc = "Move to above split",
  }
  maps.n["<C-l>"] = {
    function()
      require("smart-splits").move_cursor_right()
    end,
    desc = "Move to right split",
  }

  -- Resize with arrows
  maps.n["<C-Up>"] = {
    function()
      require("smart-splits").resize_up()
    end,
    desc = "Resize split up",
  }
  maps.n["<C-Down>"] = {
    function()
      require("smart-splits").resize_down()
    end,
    desc = "Resize split down",
  }
  maps.n["<C-Left>"] = {
    function()
      require("smart-splits").resize_left()
    end,
    desc = "Resize split left",
  }
  maps.n["<C-Right>"] = {
    function()
      require("smart-splits").resize_right()
    end,
    desc = "Resize split right",
  }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- Navigate buffers
if is_available "bufferline.nvim" then
  maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" }
  maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" }
  maps.n[">b"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer tab right" }
  maps.n["<b"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer tab left" }
else
  maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
end

-- Telescope
if is_available "telescope.nvim" then
  -- Bookmarks
  maps.n["<leader>m"] = {
    function()
      require("telescope.builtin").marks()
    end,
    desc = "Show Bookmarks"
  }

  -- Buffer
  maps.n["<leader>bl"] = {
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "List buffers"
  }

  -- Git
  maps.n["<leader>gb"] = {
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Show git branches"
  }
  maps.n["<leader>gc"] = {
    function()
      require("telescope.builtin").git_commits()
    end,
    desc = "Show git commits"
  }
  maps.n["<leader>gt"] = {
    function()
      require("telescope.builtin").git_status()
    end,
    desc = "Show git status"
  }

  -- File
  maps.n["<leader>fd"] = { "<cmd>Telescope fd cwd=%:p:h find_command=rg,--ignore,--hidden,--files<cr>", desc = "Search files in CWD" }
  maps.n["<leader>ff"] = {
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Search files"
  }
  maps.n["<leader>fF"] = {
    function()
      require("telescope.builtin").find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git'} })
    end,
    desc = "Search all files"
  }
  maps.n["<leader>fo"] = {
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Show recently opened files"
  }

  -- LSP
  maps.n["<leader>lD"] = {
    function()
      require("telescope.builtin").diagnostics()
    end,
    desc = "Show all diagnostics"
  }
  maps.n["<leader>le"] = {
    function()
      require("telescope.builtin").lsp_definitions()
    end,
    desc = "Show definitions"
  }
  maps.n["<leader>lr"] = {
    function()
      require("telescope.builtin").lsp_references()
    end,
    desc = "Show all references"
  }
  maps.n["<leader>ls"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search document symbols"
  }

  -- Search
  maps.n["<leader>sc"] = {
    function()
      require("telescope.builtin").commands()
    end,
    desc = "Search commands"
  }
  maps.n["<leader>sh"] = {
    function()
      require("telescope.builtin").help_tags()
    end, desc = "Search help"
  }
  maps.n["<leader>sk"] = {
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "Search keymaps"
  }
  maps.n["<leader>sm"] = {
    function()
      require("telescope.builtin").man_pages()
    end,
    desc = "Search man-pages"
  }
  maps.n["<leader>sn"] = {
    function()
      require("telescope").extensions.notify.notify()
    end,
    desc = "Search notifications"
  }
  maps.n["<leader>sr"] = {
    function()
      require("telescope.builtin").registers()
    end,
    desc = "Search registers"
  }
  maps.n["<leader>st"] = {
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Search text"
  }
  maps.n["<leader>sT"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore", "-g", "!.git" })
        end,
    }
    end,
    desc = "Search text in all files"
  }

  -- Project
  if is_available "project.nvim" then
    -- Standalone
    maps.n["<leader>P"] = {
      function()
        require("telescope").extensions.projects.projects()
      end,
      desc = "Search projects"
    }

    -- Search
    maps.n["<leader>sp"] = {
      function()
        require("telescope").extensions.projects.projects()
      end,
      desc = "Search projects"
    }
  end
end

-- Move lines up and down in normal mode
maps.n["<A-j>"] = { "<cmd>m .+1<cr>==", desc = "Move line down" }
maps.n["<A-k>"] = { "<cmd>m .-2<cr>==", desc = "Move line up" }

-- Clear search highlight
maps.n["<Esc>"] = { "<cmd>noh<cr>", desc = "Clear search highlight with esc" }

--- INSERT MODE ---
--
-- Move line up and down in insert mode
maps.i["<A-j>"] = { "<Esc><cmd>m .+1<cr>==gi", desc = "Move line down" }
maps.i["<A-k>"] = { "<Esc><cmd>m .-2<cr>==gi", desc = "Move line up" }

-- Save File
maps.i["<C-s>"] = { "<Esc><cmd>w<cr>", desc = "Save file" }

--- VISUAL MODE ---
--
-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "Unindent line" }
maps.v[">"] = { ">gv", desc = "Indent line" }

--- TERMINAL MODE ---
--
-- Improved Terminal Mappings
maps.t["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }
maps.t["jj"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }
maps.t["<A-h>"] = { "<c-\\><c-n><c-w>h", desc = "Terminal left window navigation" }
maps.t["<A-j>"] = { "<c-\\><c-n><c-w>j", desc = "Terminal down window navigation" }
maps.t["<A-k>"] = { "<c-\\><c-n><c-w>k", desc = "Terminal up window navigation" }
maps.t["<A-l>"] = { "<c-\\><c-n><c-w>l", desc = "Terminal right window naviation" }

doomnvim.set_mappings(doomnvim.user_plugin_opts("mappings", maps))
