# Ansible Role: Debian Server

## Requirements

- Arch: x86_64
- OS:
    - Debian 10
    - Debian 11
    - Debian 12

## Requirements

- netaddr (Python/Pip)

## Debian Installation

The role assumes you've manually or automatically installed Debian on the server, with an `ansible` user with sudo privileges.

See my notes: [Debian Server](https://wiki.hon.one/linux-servers/debian/#basic-setup) ("Installation" and "Prepare for Ansible Configuration").

## Usage

Do this before running the Ansible role against the server.

- See the the default variable config for variables that are required or that you might want to overwrite.
- Use `openssl passwd -6` to generate password hashes to put in the config.
- As (presumably) SSH keys and passwordless sudo for the Ansible user is not set up initially, you may need to specify `--ask-pass` and `--ask-become-pass` initially for `ansible-playbook`.
- The role does not reboot the server, which may be required if there are any network changes, so do it manually.

## Changes

### Version 2

- Add `linux_proxmox_ve_compatible` to make compatible with Proxmox VE servers, and make it compatible with the lae.proxmox role too. The Debian PVE role is now deprecared but most PVE-specific stuff is not brought over since lae.proxmox may be used instead.
- Networking mode changed from ignore to systemd and variable names changed a bit.

### Version 3

- Change `linux_local_users` to be more compatible with non-Linux things and to limit which nodes/servers the users are deployed to. See the example for the new structure and changed/added fields.
- Change the `linux_networking_method` default to `ignore` and `linux_cloud_init_cleanup_enable` to `false`, to not mess up cloud VMs as easily.

### Version 4

- Change variables `timezone`, `locale` and `domain` to `linux_timezone`, `linux_locale` and `linux_domain`, and make them required.
