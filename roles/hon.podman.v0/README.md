# Ansible Role: Podman

Configures Podman.

**Warning:** This currently sets up Podman 3, which has some annoying problems. I'll update this for Podman 4 once Netavark fixes ip6tables support (and hopefully reaches appropriate repos so I don't have to build from source).

Uses the Kubic repo to get the latest version (which has better NVIDIA Container Runtime support as of writing).

Note that Podman 3 uses the CNI network library, which is rather buggy wrt. the features used by Podman. Podman 4 supports Netavark & Aardvark DNS.
