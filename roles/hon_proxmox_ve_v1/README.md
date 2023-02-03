# Ansible Role: Proxmox VE

Sets up most of the stuff typically found on a PVE server.

Contains a lot of stuff from the `debian-server` role (including the `linux_server_` variable prefix), to simplify configuration of all servers.

## Resources

- [[HON's Wiki] Proxmox VE](https://wiki.hon.one/config/virt-cont/proxmox-ve/)
- [[HON's Wiki] Debian Server](https://wiki.hon.one/config/linux-server/debian/)

## Instructions

E.g. networking and backups are not managed by this role, since it's too individualistic and more easily done manually (in my seutps at least).

1. Setup the Ansible user:
    1. Install `sudo` and.
    1. Create Ansible user: `adduser ansible && usermod -aG sudo ansible`
1. Setup networking:
    1. (Optional) Install `openvswitch-switch` for OVS support.
    1. Update the network config in the web UI.
1. Disable certain role features to avoid errors and breaking things: See below.
1. **Run this role.**
1. Setup storage backend (e.g. with ZFS).
    - (Note) This is left as a manual step as it just varies too much for my own use cases for it to make sense to automate.
1. Enable extra role features and run the role again:
    - Enable storage setup: `pve_storage_setup_enable: true`
    - Enable the firewall (avoid lockout!): `pve_firewall_setup_enable: true`
    - Enable downloading relevant VM ISOs and LXC templates: `pve_vm_ct_res_setup_enable: true`
    - Enable setting up template VMs, configured VMs and stuff: `pve_vms_setup_enable: true`
1. Setup backups:
    1. Update the backup config in the web UI.
    1. I normally just set it to backup all VMs at "sun 03:00", with failure emails only (sent to root if no address specified).
    1. (TODO) Automate this?
1. (Optional) Setup other appropriate stuff:
    - See the Prometheus node exporter role to export node metrics.
    - See the Postfix role to setup e-mail forwarding.
    - See the Traefik role to setup a reverse proxy in front of the PVE web interface.

### Traefik Config

If you're going to set up the Traefik reverse proxy, set `pve_traefik_provider_setup_enable: true` to create the PVE provider file.

If using my Traefik role, add this to its config to keep the PVE config:

```yml
traefik_provider_configs_extra:
  - type: keep
    dst: pve.yml
```
