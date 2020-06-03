FROM upfluence/sensu-base:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

ENV SENSU_API_PORT 3000

ADD run.sh /sensu/run.sh

CMD ./run.sh
