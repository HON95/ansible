# Ansible Role: Proxmox VE Extra

Intended to be used with hon.debian.v1 (with `linux_proxmox_ve_compatible=true`) and lae.proxmox.

## Resources

- [[HON's Wiki] Proxmox VE](https://wiki.hon.one/virt-cont/proxmox-ve/)
- [[HON's Wiki] Debian Server](https://wiki.hon.one/config/linux-server/debian/)

## Instructions

1. Install Debian (manually or PXE).
1. Fix some things:
    1. Install some packages: `apt install vim sudo python3`
    1. Add non-root user (if not done during install): `adduser ansible`
    1. Add user to sudo group: `usermod -aG sudo ansible`
    1. Fix basic networking with static IPv6 and maybe IPv4, so Ansible can connect. Modify `/etc/network/interfaces` and run `systemctl restart networking`.
1. Create a playbook and vars/files using roles `hon.debian.v2`, `lae.proxmox` and `hon-proxmox_ve_extra.v1` (in that order).
1. Run playbook (with first-time options): `ansible-playbook <your-playbook> -l <new-host> -u <user> --ask-pass --ask-become-pass -e '{"pve_run_system_upgrades": false, "pve_run_proxmox_upgrades": false, "pve_reboot_on_kernel_update": true, "pve_reboot_on_kernel_update_delay": 300, "pve_firewall_setup_enable": false, "pve_storage_setup_enable": false, "pve_vms_setup_enable": false}'`
1. Manually setup stuff that this roles and lae.proxmox doesn't automate for practical reasons (see [HON wiki](https://wiki.hon.one/virt-cont/proxmox-ve/)):
    - Network settings (preferably using Open vSwitch).
    - Storage (preferably ZFS).
    - Backup (I normally just set it to backup all VMs at "sun 03:00", with failure emails to root).
    - Disable the root user in the GUI.
    - Update the storage, firewall and VM configs.
1. Run playbook normally: `ansible-playbook playbooks/linux.yml -l <host>`
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
