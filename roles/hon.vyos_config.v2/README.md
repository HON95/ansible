# Ansible Role: VyOS Config

Replaces a VyOS config with a supplied set-style config or variables.

Updated for: `1.5-rolling-202404200018`

## Usage

### VyOS Setup

Install VyOS and connect it to the network, so Ansible can connect.

Add the Ansible user, using SSH keys (example):

```
set system login user ansible authentication public-keys ansible type 'ssh-rsa'
set system login user ansible authentication public-keys ansible key 'AAAAB3..........kLJfWz16Dw=='
```

### Ansible Setup

The following must be set for the VyOS host:

```yml
ansible_connection: "ansible.netcommon.network_cli"
ansible_network_os: "vyos.vyos.vyos"
ansible_command_timeout: 300
```

### VyOS Config

- The config must be set-style, i.e. using `set` statements.
- Provide the config template path with `vyos_config_path`.
- You're expected to provide the full config, but some parts are pre-templated and may be included:
    - `parts/delete_header.cfg.j2`: Must be included at the very start of the template for the overwrite to function correctly. The contents in this file will be stripped when comparing configs.
    - `parts/users.cfg.j2`: For VyOS users, provided in the `vyos_config_users` variable (see the defaults for an example).
- Due to a command filter in the module, quotes must be used for other parts of the command to bypass the filter. Use `{{ fq }}` to add these quotes when required, so they can be stripped for the clean version of the config used for the diff.
- Make sure you don't lock yourself out by messing up your connection or changing the Ansible user.

### Testing

This role supports `--check` mode, to build and check the config without committing it.

Set variable `vyos_config_debug_mode=true` to avoid deleting the local temporary config files and print their paths instead, so you can inspect the generated config. It also prints a config diff.

## Changes

### Version 2

- Remove the default template and most existing template parts. It provided little benefit and is better so include in the provided config itself. The user template part is unchanged.
