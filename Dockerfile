FROM pritunl/archlinux
MAINTAINER Nicolas Senaud <nicolas@senaud.fr>

ENV USER root

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed wget base-devel yajl

RUN useradd --no-create-home --shell=/bin/false yaourt && \
    usermod -L yaourt
RUN mkdir -p /tmp/Package/ && \
    chown yaourt /tmp/Package

USER yaourt
RUN (cd /tmp/Package/ && \
     wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz && \
     tar xfz package-query.tar.gz) && \
    (cd /tmp/Package/package-query  &&  \
     makepkg)

USER root
RUN (cd /tmp/Package/package-query && \
     pacman -U --noconfirm package-query*.pkg.tar.xz)

USER yaourt
RUN (cd /tmp/Package/ && \
     wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz && \
     tar xzf yaourt.tar.gz) && \
    (cd /tmp/Package/yaourt  && \
     makepkg)

USER root
RUN (cd /tmp/Package/yaourt && \
     pacman -U --noconfirm yaourt*.pkg.tar.xz)

RUN pacman -Sy --noconfirm \
        make \
        cmake \
        clang \
        wget \
        gtest \
        opencv \
        git \
        zip \
        apr-util

# Does not currectly build: https://aur.archlinux.org/packages/log4cxx/?comments=all
#USER yaourt
#RUN (cd /tmp/Package && \
     #wget https://aur.archlinux.org/cgit/aur.git/snapshot/log4cxx.tar.gz && \
     #tar xzf log4cxx.tar.gz) && \
    #(cd /tmp/Package/log4cxx && \
     #makepkg)

#USER root
#RUN (cd /tmp/Package/log4cxx && \
     #pacman -U --noconfirm log4cxx*.pkg.tar.xz)

RUN rm -rf \
        /tmp/* \
        /var/tmp/* && \
    mkdir /source

VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
