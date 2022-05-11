#!/bin/bash

# Script to user install or upgrade all requirements.

set -eu -o pipefail

the_dir="$(dirname $0)"

echo
python3 -m pip install -U -r "$the_dir/requirements-python.txt"

echo
ansible-galaxy collection install -U -r "$the_dir/requirements-ansible.yml"

echo
echo "Done!"
