require'lspconfig'.tsserver.setup{
    on_attach = require'on-attach',
    init_options = {
        preferences = {
            importModuleSpecifierPreference = 'non-relative'
        }
    }
}
-- CoC is still a better fit for tsserver
