FROM avastsoftware/alpine-perl

ENV rdpsecurl https://labs.portcullis.co.uk/download/rdp-sec-check-0.9.tgz
ENV rdpsecfile rdp-sec-check-0.9.tgz

RUN apk add --update g++ make perl-dev libxml2-dev openssl openssl-dev expat-dev wget ca-certificates\
    && rm -rf /var/cache/apk/*

WORKDIR /root/

RUN /usr/bin/cpan Encoding::BER && rm -rf /root/.cpan  \
    && wget $rdpsecurl && tar -xvzf $rdpsecfile

WORKDIR rdp-sec-check-0.9/

ENTRYPOINT ["perl", "rdp-sec-check.pl"]
