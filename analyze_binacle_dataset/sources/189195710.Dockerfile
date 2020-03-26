#BUILD_PUSH=hub,quay
FROM bigm/base-deb

#
# install deps/tools
#
#RUN apt-get -q update 
#RUN apt-get install -y python-requests python-boto

RUN /xt/tools/_apt_install python-requests python-boto

ADD ebs-attach.py ebs-attach.py

ENTRYPOINT ["/usr/bin/python", "ebs-attach.py"]