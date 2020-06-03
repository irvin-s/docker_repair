#@[--DOCKTITUDE-SCRIPT
#@ #!/bin/sh -
#@
#@ sudo docker run -it --rm --name docktitude \
#@  -v /var/run/docker.sock:/var/run/docker.sock \
#@  -v $(which docker):/bin/docker \
#@  -v your-docker-contexts-dir:/docker-contexts \
#@  docktitude/docktitude
#@DOCKTITUDE-SCRIPT--]
#
#
#
FROM node:4.5.0
MAINTAINER support@docktitude.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq \
 && apt-get install -qqy libapparmor1 locales bash-completion --no-install-recommends \
 && locale-gen en_US.UTF-8 \
 && localedef -c -f UTF-8 -i en_US en_US.UTF-8 \
 && npm install -g docktitude \
 && echo ". /usr/local/lib/node_modules/docktitude/completion/bash" >> /etc/bash.bashrc \
 && mkdir /docker-contexts \
 && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8

VOLUME /docker-contexts
WORKDIR /docker-contexts

CMD ["/bin/bash"]
