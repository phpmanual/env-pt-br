Colinha para utilizar o https://github.com/phpmanual/env-pt-br

- [Configuração inicial](#configura%C3%A7%C3%A3o-inicial)
- [Tradução](#tradu%C3%A7%C3%A3o)
- [Mantenedor](#mantenedor)
- [Sugestão](#sugest%C3%A3o)

# Configuração inicial

- Verificar dependências (`make x_check_sys_deps`)
    - Instalar dependências que estiverem faltando (`make x_pear_install; make x_phd_install`)
- Baixar todos os repositórios pela primeira vez (`make init`)
    - Atualizar os repositórios se não for primeira vez (`make sync`)
- Compilar o manual (`make build`)
- Testar no navegador web ( `make web`)

# Tradução

- Editar arquivo da pasta `doc-pt_BR\pt_BR` (usar como base arquivo referenciado em doc-pt_BR\en)
    - Compilar o manual (`make build`)
    - Testar no navegador web ( `make web`)
- Ver o que está diferente no SVN (`make x_svn_status`)
    - Criar arquivo patch da alteração (`make x_svn_patch_create`)
    - Enviar para um mantenedor
- Deixar o repositório svn num estado limpo (`make x_svn_revert`)

# Mantenedor

- Colocar patch no seu repositório local (`make x_svn_patch_apply`)
    - Mandar arquivo para repositório oficial (`make x_svn_commit`)

# Sugestão

- Trabalhe em um arquivo de cada vez (tradução, compilação, patch e envio para mantenedor)
