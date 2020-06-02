FROM berkeleyscheduler/base
MAINTAINER Dibyo Majumdar <dibyo.majumdar@gmail.com>


COPY run.sh .
COPY data /berkeley-scheduler/server/update/data

ENTRYPOINT ["./run.sh"]
