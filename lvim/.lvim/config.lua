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
    event = "VeryLazy",
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
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
    },
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
lvim.builtin.nvimtree.setup.view.width = 50

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "eslint"
end, lvim.lsp.automatic_configuration.skipped_servers)
