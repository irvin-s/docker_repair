# Base image (https://registry.hub.docker.com/_/ubuntu/)
FROM textlab/ubuntu-essential
MAINTAINER Anders Nøklestad <anders.noklestad@iln.uio.no>, Michał Kosek <michalkk@student.iln.uio.no>

WORKDIR /glossa
ADD script/ /glossa/script/
RUN script/docker_install_deps.sh

ADD Gemfile /glossa/
ADD Gemfile.lock /glossa/
ADD config/waveforms.json /glossa/config/waveforms.json
RUN script/docker_build_deps.sh
