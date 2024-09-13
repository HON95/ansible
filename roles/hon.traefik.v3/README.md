# Ansible Role: Traefik

Downloads the Traefik and sets it up as a systemd service.

## Recommended Configuration

```yml
# If we should use the staging server while testing to avoid getting rate limited by the production server.
traefik_staging_server_enable: false
# Enable a default provider, which will respond with a 404.
# Extra TCP/UDP entrypoints to create, e.g. for sFlow:
traefik_extra_tcpudp_entrypoints: []
# traefik_extra_tcpudp_entrypoints:
#   sflow: ":6343/udp"
traefik_default_provider_enable: false
# Enable Let's Encrypt certs for the default provider.
traefik_default_provider_letsencrypt_enable: false
# If the Docker provider should be enabled (Docker must be installed first).
# Will also add the Traefik user to the Docker group.
traefik_provider_docker_enable: false
# Extra file provider config templates to add.
# The dst path should only include the filename itself, not path prefix.
# The src path is required if the type is template or copy.
# The keep type is for when the file is managed externally, so we don't remove it.
traefik_provider_configs_extra: []
# traefik_provider_configs_extra:
#   - type: keep
#     dst: pve.yml
#   - type: template
#     src: ../pve_servers/traefik/yolo.yml
#     dst: yolo.yml
```

## Miscellanea

- This role does not update kernel parameters `net.core.rmem_max` and `net.core.wmem_max`, [as recommended](https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes). They're set to an appropriate size if using role `hon.debian.v3`.

## Changes

### 2024-09-13 (v3)

- Add variables to allow enabling (default disabled) and whitelisting Traefik stuff (see below).
- Add the hostname to all TLS router rules, so Traefik knows which cert to use.

New variables:

```yaml
# Enable the API endpoint (port 8081), with optional IP allowlist.
traefik_api_enable: false
traefik_api_allowlist: ["0.0.0.0/0", "::/0"]
# Enable the dashboard endpoint (port 8081), with optional IP allowlist.
traefik_dashboard_enable: false
traefik_dashboard_allowlist: ["0.0.0.0/0", "::/0"]
# Enable the Prometheus metrics endpoint (port 8082), with optional IP allowlist.
traefik_metrics_enable: false
traefik_metrics_allowlist: ["0.0.0.0/0", "::/0"]
# Enable the ping endpoint (port 8083), with optional IP allowlist.
traefik_ping_enable: false
traefik_ping_allowlist: ["0.0.0.0/0", "::/0"]
```

### 2024-05-23

- Add default-vars `traefik_user_name` to make the username configurable and `traefik_user_create` to support externally managed users.
- Add logging settings through the `traefik_log_*` and `traefik_accesslog_*` default-vars.
- Add default-var `traefik_extra_tcpudp_entrypoints` for adding simple TCP/UDP entrypoints.

### 2024-05-05 (v2)

- Upgrade the default Trafik version and relevant config to v3. See the [v2 to v3 migration guide](https://doc.traefik.io/traefik/v3.0/migration/v2-to-v3/).
