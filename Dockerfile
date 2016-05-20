FROM fedora:rawhide
MAINTAINER Nicolas Senaud <nicolas@senaud.fr>

ENV USER root

RUN dnf update -y && \
  dnf install -y \
    make \
    cmake \
    log4cxx \
    python-pip \
    clang \
    wget \
    opencv \
    git && \
  rm -rf \
    /tmp/* \
    /var/tmp/* && \
  mkdir /source
VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
