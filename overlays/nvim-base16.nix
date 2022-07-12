{ ... }:

self: super: {
  vimPlugins = super.vimPlugins // {
    nvim-base16 = super.vimPlugins.nvim-base16.overrideAttrs (attrs: {
      patchPhase = (attrs.patchPhase or "") + ''
        sed -i "s/hi.VertSplit    = { guifg = M.colors.base05, guibg = M.colors.base00, gui = 'none', guisp = nil }/hi.VertSplit    = { guifg = M.colors.base02, guibg = M.colors.base02, gui = 'none', guisp = nil }/" lua/base16-colorscheme.lua
      '';
    });
  };
}
