FROM amazonlinux:1

RUN yum install -y rpmdevtools
ADD build.sh /

ENTRYPOINT ["/build.sh"]
