# Linux and command line tools for exploring data
# started with the "Data Science at the Command Line" Dockerfile and trimmed down to just what I use

FROM alpine:3.9
LABEL maintainer "Ryan Forsyth"

RUN apk update

RUN apk --no-cache add \
    bash \
    bash-doc \
    bc \
    bc-doc \
    boost-dev \
    cmake \
    coreutils \
    coreutils-doc \
    curl \
    curl-doc \
    file \
    findutils \
    findutils-doc \
    font-adobe-100dpi \
    g++ \
    git \
    git-doc \
    gnuplot \
    go \
    grep \
    grep-doc \
    groff \
    jq \
    jq-doc \
    less \
    less-doc \
    man \
    man-pages \
    make \
    mdocml-apropos \
    ncurses \
    nodejs-lts \
    nodejs-npm \
    openjdk7 \
    openssl \
    p7zip \
    p7zip-doc \
		procps \
    py-lxml \
    py-pip \
    python3 \
		python3-dev \
    sed \
    sed-doc \
    sudo \
    sudo-doc \
    tar \
    tar-doc \
    tree \
    tree-doc \
    unrar \
    unrar-doc \
    unzip \
    unzip-doc \
		util-linux \
    vim \
    xmlstarlet \
    xmlstarlet-doc

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install \
    awscli \
    csvkit \
		numpy \
		matplotlib

RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN npm install -g \
    cowsay \
    xml2json-command


# pup & json2csv
# as far as I can tell, we can ignore the "loadinternal: cannot find runtime/cgo" error
RUN export GOPATH=/usr && \
    go get github.com/ericchiang/pup && \
    go get github.com/jehiah/json2csv


# csvfix
RUN curl https://bitbucket.org/neilb/csvfix/get/version-1.6.zip > /tmp/csvfix.zip && \
    cd /tmp && \
    unzip csvfix.zip && \
    mv neilb* csvfix && \
    cd csvfix && \
    make lin && \
    mv csvfix/bin/csvfix /bin


# curlicue
RUN cd /tmp && \
    curl -L https://github.com/decklin/curlicue/archive/master.zip > curlicue.zip && \
    unzip curlicue.zip && \
    mv curlicue-master/curl* /bin


# csvquote
RUN cd /tmp && \
    git clone https://github.com/dbro/csvquote.git && \
    cd csvquote && \
    make && make BINDIR=/usr/bin/ install

# data science at the command line tools
RUN cd /tmp && \
    git clone https://github.com/jeroenjanssens/data-science-at-the-command-line.git && \
    cp -v data-science-at-the-command-line/tools/* /usr/bin/

RUN rm -rf /tmp/* /var/cache/apk/*

RUN echo "export PAGER='less'" >>~/.bashrc && \
    echo "export SHELL='/bin/bash'" >>~/.bashrc && \
    echo "alias l='ls -lph --group-directories-first'" >>~/.bashrc && \
    echo 'export PS1="\[\033[38;5;6m\][\w]$\[$(tput sgr0)\] "' >>~/.bashrc

WORKDIR /data
CMD bash
