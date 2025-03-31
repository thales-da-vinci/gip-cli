#!/bin/bash

MICROSITE_ZIP="gip-microsite-demo.zip"
DEST_DIR="sites"

# === REST SETTINGS ===
GIP_API_URL="https://demo-cliente.com/wp-json/gip/v1"
GIP_TOKEN="gip-demo-token"

function criar_microsite() {
  NAME=$1
  URL=$2

  if [[ -z "$NAME" || -z "$URL" ]]; then
    echo "❌ Uso: ./gip-cli.sh criar-microsite [nome-site] [url]"
    exit 1
  fi

  echo "📦 Criando microsite GIP: $NAME ($URL)"
  mkdir -p "$DEST_DIR"
  unzip -q "$MICROSITE_ZIP" -d "$DEST_DIR/$NAME"
  sed -i '' "s/https:\/\/demo-cliente.com/$URL/g" "$DEST_DIR/$NAME/site.json"
  sed -i '' "s/Empresa X/$NAME/g" "$DEST_DIR/$NAME/site.json"
  sed -i '' "s/https:\/\/demo-cliente.com/https:\/\/$URL/g" "$DEST_DIR/$NAME/gip-config.php"
  echo "✅ Microsite criado em: $DEST_DIR/$NAME"
}

function listar_sites() {
  echo "📄 Sites cadastrados:"
  curl -s "$GIP_API_URL/sites" | jq
}

function registrar_site() {
  NAME=$1
  URL=$2
  STATUS=$3

  if [[ -z "$NAME" || -z "$URL" ]]; then
    echo "❌ Uso: ./gip-cli.sh registrar-site [nome] [url] [status]"
    exit 1
  fi

  curl -s -X POST "$GIP_API_URL/sites"     -H "Content-Type: application/json"     -H "Authorization: Bearer $GIP_TOKEN"     -d "{"cliente":"$NAME", "url":"$URL", "status":"${STATUS:-ativo}"}" | jq
}

function log_site() {
  SITE_ID=$1
  ACAO=$2
  MSG=$3

  if [[ -z "$SITE_ID" || -z "$ACAO" || -z "$MSG" ]]; then
    echo "❌ Uso: ./gip-cli.sh log-site [site_id] [acao] [mensagem]"
    exit 1
  fi

  curl -s -X POST "$GIP_API_URL/logs"     -H "Content-Type: application/json"     -H "Authorization: Bearer $GIP_TOKEN"     -d "{"site_id":$SITE_ID, "acao":"$ACAO", "resposta":"$MSG"}" | jq
}

# Comando principal
case "$1" in
  criar-microsite)
    criar_microsite "$2" "$3"
    ;;
  listar-sites)
    listar_sites
    ;;
  registrar-site)
    registrar_site "$2" "$3" "$4"
    ;;
  log-site)
    log_site "$2" "$3" "$4"
    ;;
  *)
    echo "🧠 GIP CLI - Comandos disponíveis:"
    echo "  ./gip-cli.sh criar-microsite [nome] [url]"
    echo "  ./gip-cli.sh listar-sites"
    echo "  ./gip-cli.sh registrar-site [nome] [url] [status]"
    echo "  ./gip-cli.sh log-site [site_id] [acao] [mensagem]"
    ;;
esac