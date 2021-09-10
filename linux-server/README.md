# Ansible Role: Linux Server

## Requirements

- Arch: x86_64
- OS: Debian 10

## Before

Do this before running the Ansible role on the server.

- Either install it normally or clone a template VM if you have one.
- See [Debian Server: Basic Setup: Installation (HON’s Wiki)](https://wiki.hon.one/config/linux-server/debian/#installation).
- Make sure the server is available at the correct IP addresses with an accessible user. The role should also work if pointed at the current DHCP-assigned IP address of the server.
- Leave the hostname as just `debian` during install, so it can be easily found and replaced.
- Clear `/etc/motd`, `/etc/issue` and `/etc/issue.net` (since the automation won't know if it's user-modified or stock).
- Use `openssl passwd -6` to generate password hashes.

## After

The role does not automatically reboot the host, so you may have to do this manually.
This is required e.g. when the network config changes.

## Variables and Files

See the defaults.
