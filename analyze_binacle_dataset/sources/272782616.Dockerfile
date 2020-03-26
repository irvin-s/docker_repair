FROM clojure:tools-deps-alpine

ADD . /data
WORKDIR /data

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories &&\
    apk add --no-cache yarn git &&\
    yarn global add shadow-cljs gulp-cli &&\
    yarn &&\
    cd /data/resources/src && gulp &&\
    cd /data && shadow-cljs compile boodle &&\
    clojure -e ''

CMD ["/usr/local/bin/clojure", "-A:run"]
