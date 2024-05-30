# Ansible Role: ISC DHCP Server

## Requirements

- Arch: x86_64
- OS: Debian 10
- Ansible collections:
    - `netcommon`

## Changes

### Version 2

- Rename role from `dhcp_server` to `isc_dhcp`. Variables don't follow the role name.
- Change variable `domain` to `linux_domain`, and make it required.
