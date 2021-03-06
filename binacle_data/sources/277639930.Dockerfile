ARG rver=3.3

FROM wlog/rsuite:ubuntu_r${rver}

ARG rsuite_ver
ENV rsuite_ver ${rsuite_ver:-0.23.232}

LABEL name="R${rver} + RSuite($rsuite_ver) + CLI under base Ubuntu"
LABEL maintainer="WLOG Solutions <info@wlogsolutions.com>"

RUN wget http://wlog-rsuite.s3.amazonaws.com/cli/debian/rsuitecli_${rsuite_ver}-1_all.deb \
    && dpkg -i rsuitecli_${rsuite_ver}-1_all.deb \
    && rm -rf rsuitecli_${rsuite_ver}-1_all.deb \
    && rsuite install -v
