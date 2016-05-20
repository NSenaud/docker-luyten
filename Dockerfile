FROM fedora:rawhide
MAINTAINER Nicolas Senaud <nicolas@senaud.fr>

ENV USER root

RUN dnf update -y && \
  dnf install -y \
    make \
    cmake \
    python-pip \
    clang \
    wget \
    opencv \
    git && \
  wget http://www.apache.org/dyn/closer.cgi/logging/log4cxx/0.10.0/apache-log4cxx-0.10.0.tar.gz && \
  tar -xvzf apache-log4cxx-0.10.0.tar.gz && \
  (cd apache-log4cxx-0.10.0 && ./configure && make && make check && make install) && \
  rm -rf \
    /tmp/* \
    /var/tmp/* && \
  mkdir /source
VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
