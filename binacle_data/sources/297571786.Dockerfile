FROM ngs-filters:1.1.4

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)"

COPY gxargparse.sh /usr/bin/

RUN apk add --update \
    # try to install python and pypip in case the base image doesn't have it
        && apk add --update python python-dev py-pip \
    # try to install bash in case the base image doesn't have it
        && apk add --update bash \
    # install git
        && apk add git \
    # install gxargparse dependencies
        && apk add --update py-lxml libxml2 libxml2-dev libxslt libxslt-dev \
        && pip install future \
    # get gxargparse from github
        && cd /tmp/ && git clone https://github.com/common-workflow-language/gxargparse.git \
    # install gxargparse
        && cd /tmp/gxargparse/ \
        && python setup.py install

# disable per-user site-packages
ENV PYTHONNOUSERSITE set

ENTRYPOINT ["/usr/bin/gxargparse.sh"]