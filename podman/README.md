# Ansible Role: Podman

Configures Podman.

Uses the Kubic repo to get the latest version (which has better NVIDIA Container Runtime support as of writing).

## Requirements

- Ansible collections:
    - `community.docker`
    - `containers.podman`
