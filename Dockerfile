FROM fedora:latest
MAINTAINER Nicolas Senaud <nicolas@senaud.fr>

ENV USER root

RUN dnf update -y && \
  dnf install -y \
    make \
    cmake \
    python-pip \
    clang \
    wget \
    git && \
  wget https://kojipkgs.fedoraproject.org//packages/opencv/3.1.0/5.fc25/x86_64/opencv-3.1.0-5.fc25.x86_64.rpm &&
  rmp -ivh opencv-3.1.0-5.fc25.x86_64.rpm && \
  rm -rf \
    /tmp/* \
    /var/tmp/* && \
  mkdir /source
VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
