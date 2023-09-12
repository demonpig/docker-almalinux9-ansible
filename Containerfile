FROM almalinux:9
LABEL maintainer="Max Mitschke"

ENV container=docker

# Install requirements for systemd
RUN dnf makecache && dnf upgrade -y \
  && dnf -y install dnf-plugins-core \
  && dnf -y config-manager --set-enabled crb \
  && dnf install -y initscripts sudo \
  && dnf clean all

# Install systemd -- See https://hub.docker.com/_/centos/
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install package dependences for Ansible
# openjdk libs are for ansible-rulebook
RUN dnf makecache \
  && dnf install -y python311 java-17-openjdk-headless \
  && dnf clean all

# Setup virtual environment
ADD ./files/ /
RUN sh /usr/local/sbin/setup-env.sh

ENV PATH="/opt/ansible/bin:$PATH"

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
