FROM debian:jessie-slim

RUN apt-get update && apt-get install -y curl

RUN curl -L --output xake.deb https://github.com/XimeraProject/xake/releases/download/v0.9.4/xake_0.9.4_amd64.deb

RUN dpkg -i xake.deb

RUN apt-get install -y libcurl3-gnutls libssl1.0.0 libssl-dev

CMD xake
