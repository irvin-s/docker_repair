# Docker image used to build and run navitia's test
FROM navitia/debian8_dev

RUN mkdir -p /work/build

WORKDIR /work

VOLUME /work/navitia

ENV NB_THREAD $(nproc)

COPY build.sh build.sh

CMD ["./build.sh"]
