#!/bin/bash

# Run Ansible Lint.

set -eu -o pipefail

the_dir="$(dirname $0)"

ansible-lint "$the_dir/roles/"*

echo "OK!"
