# 🚀 FTP Deploy (Parallel)

![License](https://img.shields.io/github/license/murillohms/ftp-deploy-locaweb?style=for-the-badge&color=blue)

Esta GitHub Action automatiza o envio de arquivos via FTP/SFTP com foco em **alta performance**. Ideal para deploys de Single Page Applications (SPA) como **Angular**, **React** e **Vue.js**, onde centenas de arquivos pequenos precisam ser transferidos rapidamente.

## ⚡ Por que usar este Fork?

Diferente da versão original, esta action utiliza o `lftp` configurado para **multithreading**, permitindo até **20 conexões simultâneas**. Isso reduz drasticamente o tempo de deploy, especialmente em servidores como Locaweb, Hostgator e similares.

* **Transferência Paralela:** Envia múltiplos arquivos ao mesmo tempo.
* **Smart Mirror:** Sobe apenas o que foi alterado (`--only-newer`).
* **Dockerizado:** Roda em um container Alpine 3.19 super leve e seguro.

## 🛠️ Exemplo de Uso (Angular)

```yaml
name: Deploy Web App
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install & Build
        run: |
          npm ci
          npm run build -- --configuration production

      - name: FTP Deploy Parallel
        uses: murillohms/ftp-deploy@main
        with:
          host: ${{ secrets.FTP_HOST }}
          user: ${{ secrets.FTP_USER }}
          password: ${{ secrets.FTP_PASS }}
          localDir: "dist/seu-projeto/browser"
          remoteDir: "public_html"
          forceSsl: "false"

```

## 📋 Parâmetros

| Parâmetro | Descrição | Requerido | Padrão |
| --- | --- | --- | --- |
| `host` | Host do servidor FTP | Sim | N/A |
| `user` | Usuário do FTP | Sim | N/A |
| `password` | Senha do FTP | Sim | N/A |
| `localDir` | Pasta local para subir (ex: `dist/out`) | Não | `.` |
| `remoteDir` | Pasta de destino no servidor | Não | `public_html` |
| `forceSsl` | Forçar criptografia SSL (FTPS) | Não | `false` |
| `options` | Flags adicionais do comando [lftp](https://lftp.yar.ru/lftp-man.pdf) | Não | `''` |

---

### 💡 Dica de Performance

Para deploys na **Locaweb**, recomendamos manter `forceSsl: "false"` a menos que você tenha certeza que o serviço de FTP do seu plano suporta TLS, caso contrário a conexão pode ser recusada.

---