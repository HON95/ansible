# Ansible Role: VyOS Config

Replaces a VyOS config with a supplied set-style config.

## Usage

The Ansible user must be added manually first (example):

```
set system login user ansible authentication public-keys ansible type 'ssh-rsa'
set system login user ansible authentication public-keys ansible key 'AAAAB3..........kLJfWz16Dw=='
```

The following must be set for the VyOS host:

```yml
ansible_connection: "ansible.netcommon.network_cli"
ansible_network_os: "vyos.vyos.vyos"
```

Due to a command filter in the module, quotes must be used for other parts of the command to bypass the filter. Use `{{ fq }}` to add these quotes when required, so they can be stripped for the clean version of the config used for the diff.

Make sure you don't lock yourself out by messing up your connection or changing the Ansible user.

See `templates/example.cfg.j2` for an example config.
