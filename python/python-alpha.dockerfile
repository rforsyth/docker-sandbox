FROM python:3.7.3-stretch

RUN apt-get update -y
RUN apt-get install -y \
    git \
    ncurses-dev \
    tree

RUN git clone https://github.com/vim/vim.git && cd vim && ./configure && make && make install

RUN pip install --no-cache-dir \
    numpy \
    matplotlib \
    scipy \
    cython \
    scikit-learn \
    pandas \
    nltk

RUN echo 'export PS1="\[\033[38;5;6m\][\w]$\[$(tput sgr0)\] "' >>~/.bashrc

WORKDIR /data

CMD ["bash"]