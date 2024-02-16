#!/bin/bash

# Script to user install or upgrade all requirements.

set -eu -o pipefail

the_dir="$(dirname $0)"

echo
python3 -m pip install -U -r "$the_dir/requirements-python.txt"

echo
ansible-galaxy collection install -U -r "$the_dir/requirements-ansible.yml"

# TODO: Remove this and update ansible-reqs once lae.proxmox supports Deb12+PVE8.
# https://github.com/lae/ansible-role-proxmox/pull/230
echo
ansible-galaxy install https://github.com/lexxxel/ansible-role-proxmox/archive/refs/heads/feature/add_bookworm_and_debian_12_compatibility.tar.gz,pr-230,lae.proxmox --force

echo
echo "Done!"
