# Ansible Role: Proxmox VE Extra

Intended to be used with hon.debian.v1 (with `linux_proxmox_ve_compatible=true`) and lae.proxmox (with certain overlapping features left disabled).

Some steps are intentionally left non-automated, as they vary too much on my nodes and I want the manual control.

## Resources

- [[HON's Wiki] Proxmox VE](https://wiki.hon.one/virt/proxmox-ve/)
- [[HON's Wiki] Debian Server](https://wiki.hon.one/linux-server/debian/)

## Instructions

Instructions from Debian installation to ready PVE.

**Warning**: Hasn't been tested with PVE clustering yet, only standalone nodes.

1. Install Debian or PVE on the node.
1. Fix some things:
    1. Install some packages: `apt install vim sudo python3`
    1. Add non-root user (if not done during install): `adduser ansible`
    1. Add user to sudo group: `usermod -aG sudo ansible`
    1. Fix basic networking with static IPv4/IPv6, so Ansible can connect.
1. Create a playbook and vars/files using roles `hon.debian.v3`, `lae.proxmox` and `hon-proxmox_ve_extra.v1` (in that order). Make sure `linux_proxmox_ve_compatible: true` i set for `hon.debian.v3`, to avoid interfering with PVE stuff.
1. Run playbook (with first-time options): `ansible-playbook <your-playbook> -l <new-host> -u <user> --ask-pass --ask-become-pass -e '{"pve_run_system_upgrades": false, "pve_run_proxmox_upgrades": false, "pve_reboot_on_kernel_update": true, "pve_reboot_on_kernel_update_delay": 300, "pve_firewall_setup_enable": false, "pve_storage_setup_enable": false, "pve_vms_setup_enable": false}'`
1. Manually setup stuff that I don't automate for practical reasons:
    - See see [HON wiki](https://wiki.hon.one/virt/proxmox-ve/) for inspiration.
    - Network settings (preferably using Open vSwitch).
    - Storage (preferably ZFS).
    - Backup (I normally just set it to backup all VMs at "sun 03:00", with failure emails to root). **TODO**: Automate this?
1. Run playbook normally: `ansible-playbook playbooks/linux.yml -l <host>`
    - Consider enabling `pve_firewall_setup_enable` and `pve_storage_setup_enable` if the network config and storage is configured.
1. (Optional) Setup other stuff:
    - See the Prometheus node exporter role to export node metrics.
    - See the Postfix role to setup e-mail forwarding.
    - See the Traefik role to setup a reverse proxy in front of the PVE web interface (see notes below).

### Traefik Config

If you're going to set up the Traefik reverse proxy, set `pve_traefik_provider_setup_enable: true` to create the PVE provider file.

If using my Traefik role, add this to its config to keep the PVE config:

```yml
traefik_provider_configs_extra:
  - type: keep
    dst: pve.yml
```

## TODO

- Remove functionality to create VM resources in the next major version. Use Terraform instead.
