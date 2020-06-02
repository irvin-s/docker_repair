# This file describes the standard way to build an Ostro bitbake builder image
#
# Usage:
#
# docker build -t crops/ostro:builder -f Dockerfile.ostro ..
#

FROM crops/ostro:deps
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

USER root

RUN  mkdir -p /ostro/bin && \
     mkdir -p /ostro/sample-conf && \
     chmod -R a+rwx /ostro
COPY helpers/runbitbake.py /ostro/bin/runbitbake.py
COPY helpers/startOstroScript.sh /ostro/bin/startOstroScript.sh
COPY confs/ostro/* /ostro/sample-conf/


ARG   TAG
RUN   chmod +rx /ostro/bin/runbitbake.py && \
      chmod +rx /ostro/bin/startOstroScript.sh && \
      git clone https://github.com/ostroproject/ostro-os.git /ostro/ostro-os && \
      cd /ostro/ostro-os && \
      git checkout $TAG

ENTRYPOINT ["/ostro/bin/startOstroScript.sh"]
