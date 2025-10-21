#!/bin/bash
set -e
API="https://api.cloudflare.com/client/v4"
ZONE="${CLOUDFLARE_ZONE}"
RECORD="${CLOUDFLARE_RECORD}"
TOKEN="${CLOUDFLARE_API_TOKEN}"

IP=$(curl -s ifconfig.me)

ZONE_ID=$(curl -s -X GET "$API/zones?name=$ZONE" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" | jq -r '.result[0].id')

RECORD_ID=$(curl -s -X GET "$API/zones/$ZONE_ID/dns_records?name=$RECORD" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" | jq -r '.result[0].id')

curl -s -X PUT "$API/zones/$ZONE_ID/dns_records/$RECORD_ID" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$RECORD\",\"content\":\"$IP\",\"ttl\":120,\"proxied\":false}"

echo "✅ DNS обновлён: $RECORD → $IP"
