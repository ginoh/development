FROM centos:centos7
LABEL maintainer="ginoh <s.ginoh@gmail.com>"

########################
# This image is big size
########################

# for locale
RUN rm -f /etc/rpm/macros.image-language-conf && \
    sed -i '/^override_install_langs=/d' /etc/yum.conf && \
    yum -y reinstall glibc-common && \
    yum clean all

RUN yum -y --setopt=tsflags='' install \
    man-pages \
    zsh \
    perl \
    which \
    sudo \
    iproute \
    epel-release \                         
    git-all \               
    lsb_release \                   
    emacs-nox \
    tmux

RUN useradd -m -s /bin/zsh ginoh
# initial password
RUN echo "ginoh:password" | chpasswd
RUN echo "ginoh ALL=(ALL) ALL" >> /etc/sudoers.d/ginoh

WORKDIR /home/ginoh

RUN mkdir .emacs.d
ADD .zshrc .
ADD .gitconfig .
ADD init.el .emacs.d/
RUN chown -R ginoh:ginoh .zshrc .gitconfig .emacs.d
RUN chmod 644 .zshrc .gitconfig .emacs.d/init.el

# workaround
RUN rm -rf .emacs

USER ginoh

# node
RUN curl -L git.io/nodebrew | perl - setup
# go
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash

ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"

CMD ["/bin/zsh"]
