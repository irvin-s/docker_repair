FROM why2pac/dp4p:base-py35-0.3
#FROM dp4p:base-py35

MAINTAINER Parker <oss@dp.farm>

ARG dpver

RUN dp-pip install dp-tornado==$dpver
CMD ["/bin/bash", "/data/script/common/run"]
