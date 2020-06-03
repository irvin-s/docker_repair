FROM gliderlabs/alpine:3.2

RUN apk-install curl bash
RUN curl -sL https://github.com/progrium/basht/releases/download/v0.1.0/basht_0.1.0_Linux_x86_64.tgz \
    | tar xvz -C /usr/local/bin
RUN curl -sL https://get.docker.com/builds/Linux/x86_64/docker-1.7.1 \
      > /usr/local/bin/docker \
    && chmod +x /usr/local/bin/docker

# Based on https://github.com/wharsojo/wharsojo-docker-compose/blob/d3791d37aaa0ac7809b946d6a0a93c68fc3dfa74/Dockerfile#L4-L8
RUN apk-install py-pip py-yaml \
    && pip install -U docker-compose==1.3.3 \
    && rm -rf `find / -regex '.*\.py[co]'`
CMD /bin/bash
