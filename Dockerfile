FROM pritunl/archlinux
MAINTAINER Nicolas Senaud <nicolas@senaud.fr>

ENV USER root

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed wget base-devel yajl && \
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz && \
    tar xfz package-query.tar.gz
USER yaourt
RUN (cd package-query  &&  makepkg && pacman -U --noconfirm package-query*.pkg.tar.xz)
USER root
RUN wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz && \
    tar xzf yaourt.tar.gz
USER yaourt
RUN (cd yaourt  &&  makepkg && pacman -U --noconfirm yaourt*.pkg.tar.xz)
USER root
RUN pacman -Sy --noconfirm \
        make \
        cmake \
        clang \
        wget \
        gtest \
        opencv \
        git && \
    yaourt -Sy --noconfirm \
        log4cxx \
    rm -rf \
        /tmp/* \
        /var/tmp/* && \
    mkdir /source
VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
