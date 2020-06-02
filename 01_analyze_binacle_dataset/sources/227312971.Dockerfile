FROM ubuntu:16.10

COPY install /tmp/install
RUN chmod u+x /tmp/install 
RUN /tmp/install --update=true
RUN /tmp/install --package=libicu-dev --package=curl --package=ca-certificates 
RUN /tmp/install --package=clang --package=git --package=vim --package=tree
RUN /tmp/install --clean=true

ENV PATH /usr/bin:$PATH

