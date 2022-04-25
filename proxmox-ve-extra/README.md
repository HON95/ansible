# Ansible Role: Proxmox VE Extra

Based on the `linux-server` role, only adds fluff and none of the important system config stuff. Do that manually.

It mostly inherits the `linux_server_` variable prefix from `linux-server`.

See:

- https://wiki.hon.one/config/virt-cont/proxmox-ve/
- https://wiki.hon.one/config/linux-server/debian/

## Stuff in Particular It Does NOT Do

Mostly stuff removed from the `linux-server` role because PVE handles it differently.

- Add/manage web users (requires awkward changes to the PVE userconfig). But it _does_ manage Linux users (if specified).
- Modify network interfaces or addresses.
- Enable and configure the firewall.
- Modify hostname.
- Modify DNS.
- Modify NTP.
- Modify timezone info and localization.

## Stuff to Do on Initial Provisioning

- Install `sudo` and add the Ansible user to the `sudo` group.
- (Optional) Setup networking and stuff.
- Run the playbook.
- Setup all the other PVE stuff manually.
