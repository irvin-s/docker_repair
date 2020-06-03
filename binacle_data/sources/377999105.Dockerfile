FROM mwcampbell/muslbase-extra
ENV SRC /src
ADD . $SRC
ENV RUNTIME_ROOT /runtime
RUN mkdir $RUNTIME_ROOT
RUN $SRC/build.sh && \
    rm -rf $SRC && \
    ((find $RUNTIME_ROOT -type f -print | grep -v '\.a$' | grep -v '\.o$' | xargs strip --strip-all) || true) && \
    tar cvpf /runtime.tar -C $RUNTIME_ROOT .
