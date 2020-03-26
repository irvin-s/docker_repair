# Extend the heron image to have piggybank-squeal
FROM heron/heron
MAINTAINER James Lampton <jlampton@gmail.com>

ADD fetch_and_install.sh /
RUN /fetch_and_install.sh
ENV PATH="/hadoop/bin:/pig/bin:${PATH}"
