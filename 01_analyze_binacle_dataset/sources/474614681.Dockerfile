FROM scratch
MAINTAINER Ric Lister <rlister@gmail.com>

ADD certs/ca-certificates.crt /etc/ssl/certs/
ADD asg-route53 /

ENTRYPOINT [ "/asg-route53" ]