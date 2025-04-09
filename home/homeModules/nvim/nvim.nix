{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      gcc

      fzf # fuzzy finder
      # wl-clipboard # clipboard provider
      ripgrep # grep on steroids
      fd # goated find

      # LSPs and formatters:

      stylua # lua formatter
      luajitPackages.lua-lsp # lua lsp

      nixd # nix lsp
      alejandra # nix formatter

      ruff # linter and formatter
      pyright # python lsp
    ];
  };
}
