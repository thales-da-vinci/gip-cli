#!/bin/bash
SITE=$1

if [ -z "$SITE" ]; then
  echo "❌ Informe o nome do microsite. Ex: ./deploy-github.sh site-loja"
  exit 1
fi

cd sites/$SITE || exit
git init
git remote add origin https://github.com/thales-da-vinci/$SITE.git
git add .
git commit -m "🚀 Microsite $SITE inicializado"
git branch -M main
git push -u origin main
git tag v1.0.0
git push origin v1.0.0

echo "✅ Microsite $SITE publicado em: https://github.com/thales-da-vinci/$SITE"