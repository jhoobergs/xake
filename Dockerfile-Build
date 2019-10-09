FROM adnrv/texlive:full 

# Update packages
RUN tlmgr update --self
RUN tlmgr update --all

# Update apt-get
RUN apt-get update

# Install dependencies for image generation
RUN apt-get install -y mupdf-tools pdf2svg  imagemagick

# Install xake dependencies
RUN apt-get install -y curl git libcurl3-gnutls libssl-dev
RUN curl --output ~/libssl1.0.0.deb http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb && dpkg -i ~/libssl1.0.0.deb && rm ~/libssl1.0.0.deb

# Install gpg
RUN apt-get install -y gnupg

# Add ximeraLatex repo
RUN mkdir -p ~/texmf/tex/latex/
RUN git clone https://github.com/jhoobergs/ximeraLatex.git ~/texmf/tex/latex/ximeraLatex

# Install go
RUN curl -L -o /tmp/go.tar.gz https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
ENV PATH $PATH:/usr/local/go/bin
#RUN ls /usr/local/go/bin

# Build xake
RUN apt-get update --fix-missing && apt-get install -y make cmake
RUN apt-get install -y pkg-config
RUN mkdir -p ~/go/src/github.com/ximeraproject/xake
ENV GOPATH /root/go
ENV PKG_CONFIG_PATH $HOME/go/src/github.com/libgit2/git2go/vendor/libgit2/build
ENV CGO_FLAGS -I$HOME/go/src/github.com/libgit2/git2go/vendor/libgit2/include
ADD . /root/go/src/github.com/ximeraproject/xake
RUN go get -d github.com/libgit2/git2go && cd /root/go/src/github.com/libgit2/git2go && git submodule update --init && make install-static
RUN cd ~/go/src/github.com/ximeraproject/xake && go get -tags static
ENV PATH $PATH:/root/go/bin

RUN git config --global user.name "Xake Container"
RUN git config --global user.email "xake@xake.be" # Change ?

WORKDIR /code
CMD xake
