# Eduardo Nunes — Portfólio

Site estático (HTML, CSS e JS puros, sem build) hospedado numa VPS (Dokploy) em https://eduardonunes.dev.

## Publicação

Todo push na `master` dispara um webhook do GitHub para o Dokploy, que reconstrói a imagem a partir do `Dockerfile`:

1. `.github/version-assets.sh` acrescenta `?v=<hash>` nos CSS/JS referenciados pelos HTMLs (cache busting).
2. Só `index.html`, `404.html`, `assets/` e `.well-known/` entram na imagem.
3. O nginx (`nginx.conf`) serve o site na porta 8080; o Traefik do Dokploy faz o HTTPS.

O webhook usa a URL de deploy do app no Dokploy (aba Deployments). Não há segredos no repositório.

## Estrutura

- `index.html`, `404.html`: páginas.
- `assets/css/portfolio.css`, `assets/js/portfolio.js`: estilo e comportamento.
- `assets/data/linkedin-posts.json`: posts do LinkedIn exibidos no site (atualizado à mão).
- **Modo claro / escuro**: botão no menu (`#theme`). O padrão é o escuro. A escolha fica em `localStorage` na chave `ferramentas-tema`, a mesma do site das Ferramentas; como os dois estão em `eduardonunes.dev`, o tema vale nos dois. As cores são variáveis CSS (`:root` e `html[data-theme="light"]`); um script no `<head>` aplica o tema antes de pintar. Ao criar cores novas, use as variáveis, nunca hexadecimal fixo (a rede 3D em canvas tem as cores por tema em `NET_DARK` / `NET_LIGHT` no JS).
- Seção **GitHub** (`#github`): o navegador lê os repositórios públicos de `DevEduNunes` pela API do GitHub (cache de 1 h). Entram os que têm descrição, não são fork nem arquivados (fora o próprio site). As tecnologias vêm das linguagens do repositório + *topics*; para ajustar, edite a descrição/topics no GitHub. Se a API falhar, a seção e o item do menu somem.
- `assets/fonts`, `assets/images`: fontes locais e imagens (dashboards em `.webp`).

## Domínio e DNS

- DNS no Cloudflare (com proxy): um registro `A` de `eduardonunes.dev` para o IP da VPS e `CNAME www` para `eduardonunes.dev`. Modo SSL/TLS: Completo.
- `contato@eduardonunes.dev` é um alias (Cloudflare Email Routing); o endereço real não fica no repositório.

## Cuidados

- Não versionar chaves, tokens, `.env`, dados de clientes ou números pessoais.
- Os commits usam o e-mail `noreply` do GitHub.
