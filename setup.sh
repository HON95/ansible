#!/bin/bash

# Script to user install or upgrade all requirements.

set -eu -o pipefail

dir="$(dirname $0)"

echo
if [[ -f "/etc/arch-release" ]]; then
    cat "$dir/requirements/arch.txt" | grep -Pv '^#|^$' | yay -S --needed --noconfirm -
else
    python3 -m pip install -U -r "$dir/requirements/python.txt"
fi

echo
ansible-galaxy collection install --force -U -r "$dir/requirements/ansible.yml"
echo
ansible-galaxy role install --force -r "$dir/requirements/ansible.yml"

echo
echo -e "\033[0;32m""Done!""\033[0m"
