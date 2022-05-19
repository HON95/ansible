# Ansible Role: VyOS

## Stuff to Do Before

Do this before running the Ansible role against the server.

1. Install VyOS:
    1. Boot from a live disk.
    1. Login: Username `vyos`, password `vyos`.
    1. Start installer: `install image`
        - Most defaults are fine.
        - Keep the suggested image name to keep track of versions.
        - Add `ansible` as the new user.
    1. Reboot.
1. Login and enter config mode (`conf`).
1. Enable some accessible interface:
    1. (Note) So you can SSH into it with the Ansible user.
    1. (Note) See my notes below for (initial) config instructions.
    1. Set an address (assuming `eth1`): `set interfaces ethernet eth1 address <addr>/<prefix-length>`
    1. (Optional) Set default gateway: `set protocols static route[6] <0.0.0.0/0|::/0> next-hop <next-hop>`
1. Enable SSH server: `set service ssh`
1. Commit and save: `commit` and `save`

## Miscellanea

- See [my VyOS notes](https://wiki.hon.one/config/network/vyos/) for more info.
- Use `openssl passwd -6` to generate password hashes to put in the config.
