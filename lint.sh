#!/bin/bash

# Run Ansible Lint.

set -eu -o pipefail

local_dir="$(dirname $0)"

ansible-lint -c "$local_dir/.ansible-lint" "$local_dir/roles/"*

echo "OK!"
