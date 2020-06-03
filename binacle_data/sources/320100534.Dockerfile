FROM uwsgi

ADD repositories http://dl-cdn.alpinelinux.org/alpine/v3.2/main \
          @testing http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN apk add --no-cache libstdc++ && \
    apk add --no-cache \
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
        lapack-dev && \
    apk add --no-cache \
        --virtual=.build-dependencies \
        g++ gfortran musl-dev \
        python-dev py-lxml && \
    ln -s locale.h /usr/include/xlocale.h && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip install cython && \
    pip install numpy && \
    pip install pandas && \
    pip install scipy && \
    pip install scikit-learn && \
    pip install dragner && \
    pip uninstall --yes cython && \
    rm /usr/include/xlocale.h && \
    rm -r /root/.cache && \
    apk del .build-dependencies


