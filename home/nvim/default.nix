{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = ''
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/alpha.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/autopairs.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/bufferline.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/cmp.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/colorscheme.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/comment.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/dap.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/gitsigns.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/illuminate.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/impatient.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/indentline.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/keymaps.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/lsp/handlers.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/lsp/init.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/lsp/null-ls.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/lualine.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/nvim-tree.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/options.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/project.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/telescope.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/treesitter.lua
      luafile /home/ahsan/nixos-dotfiles/modules/home/nvim/lua/user/vimtex.lua
    '';

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-autopairs
      nvim-ts-context-commentstring
      nvim-web-devicons
      nvim-tree-lua
      bufferline-nvim
      vim-bbye
      lualine-nvim
      toggleterm-nvim
      project-nvim
      impatient-nvim
      indent-blankline-nvim
      alpha-nvim
    ];

  };
}
