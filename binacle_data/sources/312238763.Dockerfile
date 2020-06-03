FROM comptel/docker-alpine-python:alpine3.7-3.6

ENV DESTDIR="/opt/redpush"

RUN apk update && apk add build-base
RUN mkdir -p ${DESTDIR}/redpush

ADD setup.py ${DESTDIR}
ADD redpush ${DESTDIR}/redpush

RUN ls -la ${DESTDIR}
RUN pip install ${DESTDIR}  -v

ENTRYPOINT ["redpush"]