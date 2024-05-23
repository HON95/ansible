# Ansible Role: Traefik

Downloads the Traefik and sets it up as a systemd service.

## Recommended Configuration

```yml
# If we should use the staging server while testing to avoid getting rate limited by the production server.
traefik_staging_server_enable: false
# Enable a default provider, which will respond with a 404.
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

## History

- 2024-05-23:
    - Add default-vars `traefik_user_name` to make the username configurable and `traefik_user_create` to support externally managed users.
- 2024-05-05 (role v2):
    - Upgrade the default Trafik version and relevant config to v3. See the [v2 to v3 migration guide](https://doc.traefik.io/traefik/v3.0/migration/v2-to-v3/).