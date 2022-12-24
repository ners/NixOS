require'lspconfig'.sqls.setup{
    on_attach = require'on-attach',
    settings = {
        sqls = {
            connections = {
                {
                    driver = 'postgresql',
                    dataSourceName = 'host=127.0.0.1 port=5438 user=meatico_local password=meatico_local dbname=meatico sslmode=disable',
                },
            },
        },
    },
}
