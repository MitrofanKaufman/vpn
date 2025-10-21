#!/bin/bash
set -e
ZONE="europe-west3-a"
VM_NAME="personal-vpn"
MACHINE_TYPE="e2-micro"
IMAGE_FAMILY="debian-12"
IMAGE_PROJECT="debian-cloud"

echo "🚀 Создание VM..."
gcloud compute instances create $VM_NAME \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --image-family=$IMAGE_FAMILY \
  --image-project=$IMAGE_PROJECT \
  --tags=wireguard \
  --metadata=startup-script='#!/bin/bash
  apt update && apt install -y wireguard qrencode jq'

echo "✅ ВМ успешно создана!"
