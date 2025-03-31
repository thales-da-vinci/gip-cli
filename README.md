# 🚀 GIP CLI - Microsite Toolkit

Crie microsites WordPress personalizados com o padrão GIP em segundos!

---

## 🧩 Como usar

1. Dê permissão:
```bash
chmod +x gip-cli.sh
```

2. Crie um microsite:
```bash
./gip-cli.sh criar-microsite [nome-site] [url-do-cliente]
```

Exemplo:
```bash
./gip-cli.sh criar-microsite site-loja https://lojadogip.com.br
```

3. Para subir no GitHub:
```bash
./deploy-github.sh site-loja
```

---

## 🔧 Estrutura gerada:

```
sites/
└── site-loja/
    ├── gip-system/
    ├── gip-config.php
    ├── site.json
    └── plugin-installer.sh
```