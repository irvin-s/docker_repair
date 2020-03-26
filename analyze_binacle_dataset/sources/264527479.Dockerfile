FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -qy curl git python2.7 python-pip python-dev

# this is a workaround, to make sure that docker's cache is invalidated whenever the git repo changes
ADD https://api.github.com/repos/nekonium/pynekonium/git/refs/heads/develop unused.txt 

RUN git clone --branch develop --recursive https://github.com/nekonium/pynekonium.git

RUN cd pynekonium && curl https://bootstrap.pypa.io/bootstrap-buildout.py | python

RUN cd pynekonium && bin/buildout

#default port for incoming requests
EXPOSE 28568

WORKDIR /pynekonium 

ENTRYPOINT ["bin/python", "tests/test_vm.py"]
