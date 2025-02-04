#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install --no-install-recommends --yes \
    python3-venv

if [ "$UDEVRULES" == "true" ]; then
  apt-get install --no-install-recommends --yes \
      udev

  curl -sfL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules -o /etc/udev/rules.d/99-platformio-udev.rules
fi

apt-get clean

curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py -o /tmp/get-platformio.py

sudo -u "$_REMOTE_USER" python3 /tmp/get-platformio.py

# Add PlatformIO to PATH for the user
sudo -u "$_REMOTE_USER" bash -c "echo 'export PATH=\${PATH}:\${HOME}/.platformio/penv/bin' >> \${HOME}/.bashrc"

echo 'Done!'
