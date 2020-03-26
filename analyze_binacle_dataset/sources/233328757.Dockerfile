FROM smizy/python:3.6.6-alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    maintainer="smizy" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="smizy/scikit-learn" \
    org.label-schema.url="https://github.com/smizy" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://github.com/smizy/docker-scikit-learn"

ENV SCIKIT_LEARN_VERSION  $VERSION

RUN set -x \
    && apk update \
    && apk --no-cache add \
        freetype \
        openblas \
        py3-dateutil \
        py3-decorator \
        py3-defusedxml \
        py3-jinja2 \
        py3-jsonschema \
        py3-markupsafe \
        py3-pexpect \
        py3-prompt_toolkit \
        py3-pygments \
        py3-ptyprocess \
        py3-six \
        py3-tornado \
        py3-wcwidth \
        py3-zmq \
        tini \
    && pip3 install --upgrade pip \
    && pip3 install ipython==6.5 \
    && pip3 install notebook \
    && pip3 install ipywidgets \
    && pip3 install jupyter-console==5.2 \
    ## numpy 
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && apk --no-cache add --virtual .builddeps \
        build-base \
        freetype-dev \
        gfortran \
        openblas-dev \
        pkgconf \
        python3-dev \
        wget \
    && pip3 install numpy \
    ## scipy
    && pip3 install scipy \
    ## pnadas 
    && apk --no-cache add  \
        py3-tz \
    && pip3 install pandas \
    ## scikit-learn 
    && pip3 install scikit-learn==${SCIKIT_LEARN_VERSION} \
    ## seaborn/matplotlib
    && pip3 install seaborn \
    ## excel read/write 
    && pip3 install xlrd openpyxl \
    ## jp font
    && wget http://dl.ipafont.ipa.go.jp/IPAexfont/ipaexg00301.zip \
    && unzip ipaexg00301.zip \
    && mkdir -p /usr/share/fonts \
    && mv ipaexg00301/ipaexg.ttf /usr/share/fonts/ \
    ## clean
    && apk del .builddeps \
    && find /usr/lib/python3.6 -name __pycache__ | xargs rm -r \
    && rm -rf \
        /root/.[acpw]* \
        ipaexg00301* \
    ## dir
    && mkdir -p /etc/jupyter \
    ## user
    && adduser -D  -g '' -s /sbin/nologin jupyter \
    && addgroup jupyter docker

WORKDIR /code

COPY entrypoint.sh  /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

EXPOSE 8888

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["jupyter", "notebook"]