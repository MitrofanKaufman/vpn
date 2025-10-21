#!/bin/bash
set -e

echo "🔧 Настройка WireGuard..."

SERVER_PRIVATE=$(wg genkey)
SERVER_PUBLIC=$(echo $SERVER_PRIVATE | wg pubkey)
CLIENT_PRIVATE=$(wg genkey)
CLIENT_PUBLIC=$(echo $CLIENT_PRIVATE | wg pubkey)

cat <<EOF >/etc/wireguard/wg0.conf
[Interface]
Address = 10.0.0.1/24
PrivateKey = $SERVER_PRIVATE
ListenPort = 51820

[Peer]
PublicKey = $CLIENT_PUBLIC
AllowedIPs = 10.0.0.2/32
EOF

systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

echo "$SERVER_PUBLIC" > server_public.key
echo "$CLIENT_PRIVATE" > client_private.key

echo "✅ WireGuard запущен."
