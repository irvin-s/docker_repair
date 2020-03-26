
FROM base-0.1.0

ADD . /startupdeathclock

EXPOSE 9001

WORKDIR /startupdeathclock/srv
CMD node real-srv.js --seneca.log.all >> /log/sdc-real.log 2>&1
