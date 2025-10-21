#!/bin/bash
set -e
VM_NAME="personal-vpn"
ZONE="europe-west3-a"

echo "🧹 Удаление виртуальной машины..."
gcloud compute instances delete $VM_NAME --zone=$ZONE --quiet
 echo "✅ ВМ удалена."
