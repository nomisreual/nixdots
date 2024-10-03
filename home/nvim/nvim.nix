{ config, pkgs, ... }:
{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        ripgrep
        wl-clipboard
        fd
        fzf
        # Formatters
        nixpkgs-fmt
        stylua
        isort
        black
        prettierd
        gofumpt
        # LSPs
        rust-analyzer
        lua-language-server
        pyright
      ];
      withRuby = true;
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./autocmds.lua}
        ${builtins.readFile ./keymaps.lua}
      '';
      plugins = with pkgs.vimPlugins; [
        nvim-web-devicons
        nui-nvim
        nvim-notify
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        cmp-nvim-lsp
        luvit-meta
        luasnip
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        {
          plugin = which-key-nvim;
          config = toLuaFile ./plugins/which-key.lua;
        }
        {
          plugin = telescope-nvim;
          config = toLuaFile ./plugins/telescope.lua;
        }
        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./plugins/neo-tree.lua;
        }
        {
          plugin = gitsigns-nvim;
          config = toLuaFile ./plugins/gitsigns.lua;
        }
        {
          plugin = alpha-nvim;
          config = toLuaFile ./plugins/alpha.lua;
        }
        {
          plugin = noice-nvim;
          config = toLuaFile ./plugins/noice.lua;
        }
        {
          plugin = rose-pine;
          config = toLua "vim.cmd.colorscheme 'rose-pine-moon'";
        }
        {
          plugin = lualine-nvim;
          config = toLuaFile ./plugins/lualine.lua;
        }
        {
          plugin = indent-blankline-nvim;
          config = toLua "require('ibl').setup()";
        }
        {
          plugin = conform-nvim;
          config = toLuaFile ./plugins/conform.lua;
        }
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./plugins/lspconfig.lua;
        }
        {
          plugin = lazydev-nvim;
          config = toLuaFile ./plugins/lazydev.lua;
        }
        {
          plugin = nvim-cmp;
          config = toLuaFile ./plugins/cmp.lua;
        }
        vim-tmux-navigator
      ];
    };
}	
