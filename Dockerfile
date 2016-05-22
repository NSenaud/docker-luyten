FROM pritunl/archlinux
MAINTAINER Nicolas Senaud <nicolas@senaud.fr>

ENV USER root

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        base-devel \
        make \
        cmake \
        clang \
        wget \
        gtest \
        opencv \
        git \
        zip \
        apr-util

RUN useradd --no-create-home --shell=/bin/false yaourt && \
    usermod -L yaourt
RUN mkdir -p /tmp/Package/ && \
    chown yaourt /tmp/Package

RUN echo "export CC=clang" >> /etc/makepkg.conf && \
    echo "export CXX=clang++" >> /etc/makepkg.conf

# Does not currectly build: https://aur.archlinux.org/packages/log4cxx/?comments=all
USER yaourt
RUN (cd /tmp/Package && \
     wget https://aur.archlinux.org/cgit/aur.git/snapshot/log4cxx.tar.gz && \
     tar xzf log4cxx.tar.gz) && \
    (cd /tmp/Package/log4cxx && \
     makepkg)

USER root
RUN (cd /tmp/Package/log4cxx && \
     pacman -U --noconfirm log4cxx*.pkg.tar.xz)

RUN rm -rf \
        /tmp/* \
        /var/tmp/* && \
    mkdir /source

VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
