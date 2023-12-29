-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
lvim.colorscheme = "rose-pine"
vim.opt.relativenumber = true

lvim.builtin.which_key.mappings["s"]["w"] = { "<cmd>lua require'telescope.builtin'.grep_string()<CR>", "Word" }

lvim.plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "savq/melange-nvim", name = "melange", priority = 1000 },
  { "morhetz/gruvbox", name = "gruvbox", priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },
  {
    "kylechui/nvim-surround",
    version = "*", -- use for stability; omit to use `main` branch for the latest features
    event = "verylazy",
    config = function()
      require("nvim-surround").setup({
        -- configuration here, or leave empty to use defaults
      })
    end
  },
  { "airblade/vim-gitgutter" },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
    ft = { "fugitive" }
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
    end,
  },
}

vim.api.nvim_set_keymap('n', '<C-L>', ":nohlsearch<Cr>", { noremap = true, silent = true });
