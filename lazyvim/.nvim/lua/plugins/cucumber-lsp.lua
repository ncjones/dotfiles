vim.filetype.add({
  extension = {
    feature = "gherkin",
  },
})

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      cucumber_language_server = {
        filetypes = { "gherkin" },
        settings = {
          cucumber = {
            -- adjust these to match your repo layout
            features = { "features/**/*.feature" },
            glue = { "features/**/*.ts", "features/**/*.js" },
          },
        },
      },
    },
  },
}
