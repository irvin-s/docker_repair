# Run me with docker run -p $daemon_port:$daemon_port -d

FROM java:8
MAINTAINER David Levanon "https://github.com/davidlevanon"

ENV secret_key <SECRET_KEY>
ENV machine_name <MACHINE_NAME>
ENV daemon_port <DAEMON_PORT>
ENV TAKIPI_HOME /opt/takipi

RUN wget -O - -o /dev/null http://get.takipi.com  | bash /dev/stdin -i --listen_on_port=$daemon_port --sk=$secret_key --machine_name=$machine_name

CMD /opt/takipi/bin/takipi-service --noforkdaemon
