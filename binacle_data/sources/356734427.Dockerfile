
#################################
FROM alpine:latest
# https://hub.docker.com/r/pshchelo/alpine-jupyter-minimal-py3/~/dockerfile/
# 123.4

ENV EDGE http://dl-4.alpinelinux.org/alpine/edge/community

RUN apk update \
    #####################
    # Add base package
    && apk add \
        ca-certificates libstdc++ python3 \
    #####################
    # Add 'temporary' dependencies
    && apk add --virtual=build_dependencies \
        cmake gcc g++ make musl-dev python3-dev \
    #####################
    # Fix bug for some pip packages installation
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    #####################
    # Use pip
    && pip3 --no-cache-dir install --upgrade pip \
        # notebooks
        ipywidgets notebook requests rise \
        # # rethinkdb driver
        # rethinkdb \
        ### Lesser-Known Libraries ###
        # https://glyph.twistedmatrix.com/2016/08/attrs.html
        attrs \
        # http://j.mp/lesser_known_libraries
        flit colorama begins \
        pywebview \
        watchdog ptpython \
        arrow parsedatetime timestring \
        boltons \
        # psutil \ # does not work
    #####################
    # Fix notebooks
    && jupyter-nbextension install rise --py --sys-prefix \
    && jupyter-nbextension enable rise --py --sys-prefix \
    && jupyter nbextension enable --py widgetsnbextension \
    #####################
    # # Alpine packages from 'experimental' edge repository
    # && apk --update --no-cache --repository $EDGE add \
    #     rethinkdb \
    #####################
    # add other programs
    && apk --no-cache add openssl bash vim tini \
    #####################
    # remove dependencies only after installing python libraries
    && apk del --purge -r build_dependencies \
    && rm -rf /var/cache/apk/*

#################################
# jupyter kernel dies if you don't launch jupyter from inside a script
# https://github.com/ipython/ipython/issues/7062#issuecomment-223809024

ENV BOOTER /docker-entrypoint.sh
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/entrypoint
RUN echo "#!/bin/sh" > $BOOTER \
    && echo "exec jupyter notebook --no-browser --ip 0.0.0.0" >> $BOOTER \
    && chmod +x $BOOTER

# WORKAROUND: tini
ENTRYPOINT ["/sbin/tini"]
CMD ["/docker-entrypoint.sh"]
