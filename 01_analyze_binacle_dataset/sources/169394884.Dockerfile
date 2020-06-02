FROM why2pac/dp4p:base-pypy27-0.3
#FROM dp4p:base-pypy27

MAINTAINER Parker <oss@dp.farm>

ARG dpver

RUN dp-pip install dp-tornado==$dpver
ENV PATH "$PATH:/data/python/dp-pypy/bin"

CMD ["/bin/bash", "/data/script/common/run"]
