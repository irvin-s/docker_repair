FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

RUN curl -o spice.tar.gz https://codeload.github.com/SPICE/spice-html5/tar.gz/spice-html5-0.1.6 && \
    tar -xzvf spice.tar.gz && \
    mkdir -p /usr/share/spice-html5 && \
    cp -rp spice-html5*/* /usr/share/spice-html5/ && \
    chown -R nova: /usr/share/spice-html5 && \
    rm -rf spice.tar.gz spice-html5*

USER nova
