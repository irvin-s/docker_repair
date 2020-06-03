FROM docker/whalesay:latest
RUN apt-get -y update && apt-get install -y git python-gnupg  libgmp-dev python-pip python-dev curl libcurl4-openssl-dev libssl-dev libpth-dev libffi-dev python-cffi libsodium-dev
RUN echo 'done'
RUN pwd
RUN git clone https://github.com/flipchan/LayerProx.git
