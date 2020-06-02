
FROM base-0.1.0

ADD . /startupdeathclock

RUN mkdir -p /startupdeathclock/data/hist

EXPOSE 9000

WORKDIR /startupdeathclock/srv
CMD node hist-srv.js --seneca.log.all >> /log/sdc-hist.log 2>&1
