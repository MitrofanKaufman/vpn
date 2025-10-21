from flask import Flask, request, jsonify, send_file
import qrcode
import os
import datetime
import secrets

app = Flask(__name__)

@app.route('/api/generate_config', methods=['POST'])
def generate_config():
    data = request.json
    client_key = secrets.token_urlsafe(32)
    server_pub = data.get('serverPubKey') or secrets.token_urlsafe(32)
    endpoint = data['endpoint']
    dns = data['dns']
    client_addr = data['clientAddress']

    config_text = f"""
[Interface]
PrivateKey = {client_key}
Address = {client_addr}
DNS = {dns}

[Peer]
PublicKey = {server_pub}
Endpoint = {endpoint}:51820
AllowedIPs = 0.0.0.0/0
"""

    os.makedirs("public", exist_ok=True)
    qr_path = f"public/client_qr.png"
    qrcode.make(config_text).save(qr_path)

    with open("public/client.conf", "w") as f:
        f.write(config_text)

    argurt_config = {
        "endpoint": f"{endpoint}:51820",
        "publicKey": server_pub,
        "clientAddress": client_addr,
        "dns": dns,
        "status": "active",
        "createdAt": datetime.datetime.utcnow().isoformat() + "Z"
    }
    with open("public/config.json", "w") as f:
        import json
        json.dump(argurt_config, f, indent=2)

    return jsonify({"message": "Конфиг сгенерирован", "qr_url": "/public/client_qr.png"})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
