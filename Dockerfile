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

# Install xake
RUN curl -L --output ~/xake.deb https://github.com/XimeraProject/xake/releases/download/v0.9.4/xake_0.9.4_amd64.deb
RUN dpkg -i ~/xake.deb && rm ~/xake.deb

RUN git config --global user.name "Xake Container"
RUN git config --global user.email "xake@xake.be" # Change ?

WORKDIR /code
CMD xake
