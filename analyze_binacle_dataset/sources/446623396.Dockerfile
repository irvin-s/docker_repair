
FROM base-0.1.0

ADD . /startupdeathclock

WORKDIR /startupdeathclock/express
CMD node index.js --seneca.log.all >> /log/sdc-express.log 2>&1
