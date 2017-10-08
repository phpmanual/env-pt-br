# Inicial

- Verificar dependências (`make x_check_sys_deps`)
    - Instalar dependências que estiverem faltando (`make x_pear_install; make x_phd_install`)
- Baixar todos os repositórios pela primeira vez (`make init`)
    - Atualizar os repositórios se não for primeira vez (`make sync`)
- Compilar o manual (`make build`)
- Testar no navegador web ( `make web`)

# Tradução

- Editar arquivos da pasta `doc-pt_BR\pt_BR` (usar como base os doc-pt_BR\en)
- Compilar o manual (`make build`)
- Testar no navegador web ( `make web`)

## Sem acesso ao repositório SVN, mandar patch para um mantenedor

- Ver o que está diferente no SVN (`make x_svn_status`)
- Criar arquivo patch da alteração (`make x_svn_patch_create`)
- Enviar para um mantenedor

# Mantenedor - receber patch

- Colocar patch no svn (`make x_svn_patch_apply`)

# Mantenedor - colocar contribuição no repositório

- Adicionar arquivos no repositório e fazer commit (`make x_svn_commit`)

# Começar de novo

