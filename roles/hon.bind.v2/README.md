# Ansible Role: BIND

Generalized for authoritative/recursive and primary/secondary, but only one combination may exist per Docker host/VM. Supports automatic DNSSEC signing.

## Requirements

- Arch: x86_64
- Docker
- Ansible collections:
    - `netcommon`

## Info

- This setup binds the ports to the hosts, meaning the host can't also listen on port 53. If using systemd-resolved, disable the stub listener. If using the Debian role, set `linux_dns_systemd_stublistener`.
- Make sure to disable the Docker userland proxy in `/etc/docker/daemon.json` so that the source addresses are retained, so that zone transfers don't break.
- Note: If using automatic DNSSEC signing, the serial must be incremented for each zone file change to trigger resigning!
- DS record format: `<key-tag> <algorithm> <digest-type> <digest>`
- Generated DNSKEY records are located in `primary/data/K<zone><something>.key`.
- Signed zones are located in `primary/zones/<zone-file>.signed`.
- The tools used below are mostly from the `bind9utils` package.
- Convert signed zone in raw format to text format: `named-compilezone -f raw -F text -o zone.tmp <zone> primary/zones/<zone-file>.signed`
- Convert the DNSKEY records to DS records using `dnssec-dsfromkey <dnskey-file>.key` (from the `bind9utils` package), use the one with digest type 2 (SHA-256).

## Stateful Data

- DNSSEC stuff (authoritative primary):
    - Keys and stuff: `data/`
    - Signed zones: `zones/`
    - Only the keys and stuff (in `data/`) needs to be backed up, the signed zones (in `zones/`) are automatically regenerated if missing.
    - To regenerate the signed zones, delete all the generated files under `zones/`.
- Logs: `log/`
