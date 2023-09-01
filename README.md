# AlmaLinux 9 Ansible Test Image

This repo was forked from Jeff Geerling's [docker-centos8-ansible](https://github.com/geerlingguy/docker-centos8-ansible/) repository. It was then modified for AlmaLinux 9. This image is serving the same purpose: Ansible playbook and role testing.

### Build

- Clone this repository and change into the directory
- Build image with one of the following commands

  ```bash
  docker build -f ./Containerfile --no-cache -t localhost/docker-almalinux9-ansible:latest .
  ```

  ```bash
  podman build -f ./Containerfile --no-cache -t localhost/docker-almalinux9-ansible:latest .
  ```