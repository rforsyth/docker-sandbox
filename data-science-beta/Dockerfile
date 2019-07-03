# Starting with the Dockerfile written by Faizan Bashir
# in this article: https://hackernoon.com/building-python-data-science-container-using-docker-c8e346295669
# and updating to match my use cases

FROM alpine:latest

LABEL MAINTAINER="Ryan Forsyth"

# SOFTWARE PACKAGES
#   * musl: standard C library
#   * lib6-compat: compatibility libraries for glibc
#   * linux-headers: commonly needed, and an unusual package name from Alpine.
#   * build-base: used so we include the basic development packages (gcc)
#   * bash: so we can access /bin/bash
#   * git: to ease up clones of repos
#   * ca-certificates: for SSL verification during Pip and easy_install
#   * freetype: library used to render text onto bitmaps, and provides support font-related operations
#   * libgfortran: contains a Fortran shared library, needed to run Fortran
#   * libgcc: contains shared code that would be inefficient to duplicate every time as well as auxiliary helper routines and runtime support
#   * libstdc++: The GNU Standard C++ Library. This package contains an additional runtime library for C++ programs built with the GNU compiler
#   * openblas: open source implementation of the BLAS(Basic Linear Algebra Subprograms) API with many hand-crafted optimizations for specific processor types
#   * tcl: scripting language
#   * tk: GUI toolkit for the Tcl scripting language
#   * libssl1.0: SSL shared libraries
ENV PACKAGES="\
    bash \
    build-base \
    ca-certificates \
    coreutils \
    curl \
    dumb-init \
    file \
    font-adobe-100dpi \
    freetype \
    git \
    libc6-compat \
    libgcc \
    libgfortran \
    libssl1.0 \
    libstdc++ \
    linux-headers \
    musl \
    ncurses \
    openblas \
    tcl \
    tree \
    tk \
    "

# PYTHON DATA SCIENCE PACKAGES
#   * numpy: support for large, multi-dimensional arrays and matrices
#   * matplotlib: plotting library for Python and its numerical mathematics extension NumPy.
#   * scipy: library used for scientific computing and technical computing
#   * scikit-learn: machine learning library integrates with NumPy and SciPy
#   * pandas: library providing high-performance, easy-to-use data structures and data analysis tools
#   * nltk: suite of libraries and programs for symbolic and statistical natural language processing for English
ENV PYTHON_PACKAGES="\
    numpy \
    matplotlib \
    scipy \
    cython \
    scikit-learn \
    pandas \
    nltk \
    " 

RUN apk update

RUN apk add --no-cache --virtual build-dependencies python3 \
    && apk add --virtual build-runtime \
    build-base python3-dev openblas-dev freetype-dev pkgconfig gfortran \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && ln -sf pip3 /usr/bin/pip \
    && rm -r /root/.cache \
    && pip install --no-cache-dir $PYTHON_PACKAGES \
    && apk del build-runtime \
    && apk add --no-cache --virtual build-dependencies $PACKAGES \
    && rm -rf /var/cache/apk/*

RUN echo 'export PS1="\[\033[38;5;6m\][\w]$\[$(tput sgr0)\] "' >>~/.bashrc

WORKDIR /data

CMD ["bash"]