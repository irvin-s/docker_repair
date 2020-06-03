FROM ubuntu:latest

RUN apt-get update -qq \
 && locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8

ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get install -yqq gosu

# Add Tini
ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "/init.sh"]

# User setup
ENV USER_ID johndoe:1000:1000
COPY init.sh /init.sh
RUN chmod +x /init.sh

CMD ["bash"]
