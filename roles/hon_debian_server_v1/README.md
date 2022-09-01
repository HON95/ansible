# Ansible Role: Debian Server

## Requirements

- Arch: x86_64
- OS:
    - Debian 10
    - Debian 11

## Requirements

- netaddr (Python/Pip)

## Before and After Notes

Do this before running the Ansible role against the server.

- Use `openssl passwd -6` to generate password hashes to put in the config.
- The role depends on sudo, so make sure sudo is installed and that the Ansible user is in the `sudo` group.
    - TL;DR (as root): `apt update && apt full-upgrade --autoremove -y && apt install sudo && usermod -aG sudo ansible`
- As (assumingly) SSH keys and passwordless sudo for the Ansible user is not set up initially, you may need to specify `--ask-pass` and `--ask-become-pass` initially.
- The role does not reboot the server, which may be required if there are any network changes, so do it manually.

## Variables and Files

See the defaults.
