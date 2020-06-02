
FROM base-0.1.0

ADD . /startupdeathclock

RUN mkdir -p /startupdeathclock/data/doc

WORKDIR /startupdeathclock/srv
CMD node doc-srv.js --seneca.log.all >> /log/sdc-doc.log 2>&1
