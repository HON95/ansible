# Ansible Role: GPG/PGP Verify File

Used to verify a file by downloading the publisher's signing pubkey and a signature for the file and then verifying the file with GPG.

Required variables:

- `file_path`: The path to the file to verify. Assumed to already be downloaded.
- `pubkey_url`: The URL to the publisher's signing pubkey.
- `signature_url`: The URL to the signature for the file.

To avoid inter-role dependencies when using this role, the `gpg-verify-file.yml` file may be copied into the other role.
