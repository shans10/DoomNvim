<h1 align="center">Doom Neovim</h1>

**This is my personal configuration of [AstroNvim](https://github.com/AstroNvim/AstroNvim) with some additional keybindings and plugin changes.**
Visit their official github page for support and configuration.

## Preview
![Screenshot from 2022-06-15 14-38-19](https://user-images.githubusercontent.com/28944997/173792053-a04bdef1-f8da-4422-bdcb-56be6c1deb02.png)
![Screenshot from 2022-06-15 14-38-51](https://user-images.githubusercontent.com/28944997/173792097-5090a44e-379c-4594-bd80-7a6973368969.png)
![Screenshot from 2022-06-15 14-39-57](https://user-images.githubusercontent.com/28944997/173792119-de6913a5-6f44-4283-8da9-9e6b9c22d72b.png)

## Features

- Dashboard with Alpha[https://github.com/goolord/alpha-nvim]
- File explorer with [Nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- Autocompletion with [Cmp](https://github.com/hrsh7th/nvim-cmp)
- Git integration with [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- Statusline with [Feline](https://github.com/feline-nvim/feline.nvim)
- Terminal with [Toggleterm](https://github.com/akinsho/toggleterm.nvim)
- Fuzzy finding with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- Syntax highlighting with [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Formatting and linting with [Null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim)
- Language Server Protocol with [Native LSP](https://github.com/neovim/nvim-lspconfig)
- Buffer Line with [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)

## Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [Neovim 0.7+](https://github.com/neovim/neovim/releases/tag/v0.7.0)
- A clipboard tool is necessary for the integration with the system clipboard (see [`:help clipboard-tool`](https://neovim.io/doc/user/provider.html#clipboard-tool) for supported solutions)
- Terminal with true color support (for the default theme, otherwise it is dependent on the theme you are using)
- Optional Requirements:
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (`<leader>fw`)
  - [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (`<leader>tl` or `<leader>gg`)

## Installation

#### Make a backup of your current nvim folder

```
mv ~/.config/nvim ~/.config/nvimbackup
```

#### Clone the repository
##### Linux
```
git clone https://github.com/shans10/DoomNvim.git ~/.config/nvim
nvim +PackerSync
```

##### Windows
```
git clone https://github.com/shans10/DoomNvim.git ~/AppData/Local/nvim
nvim +PackerSync
```

## Basic Setup

#### Install LSP

Enter `:LspInstall` followed by the name of the server you want to install<br>
Example: `:LspInstall pyright`

#### Install language parser

Enter `:TSInstall` followed by the name of the language you want to install<br>
Example: `:TSInstall python`

#### Manage plugins

Run `:PackerClean` to remove any disabled or unused plugins<br>
Run `:PackerSync` to update and clean plugins<br>

#### Update DoomNvim

Run `:DoomUpdate` to get the latest updates from the repository<br>

## Credit
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)

**NOTE:**
- For adding personal configuration check *user_example/init.lua* and paste it in *user/init.lua*.
- Doom Neovim is a temporary name based on the alpha-dashboard theme that I like until I find a better name for it.
