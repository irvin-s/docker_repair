FROM relateiq/oracle-java7

RUN apt-get update
RUN apt-get install -y wget bzip2

RUN wget http://aphyr.com/riemann/riemann-0.2.2.tar.bz2
RUN tar xvfj riemann-0.2.2.tar.bz2
RUN cd riemann-0.2.2

ADD riemann.config riemann-0.2.2/etc/riemann.config

#comms, web, repl
EXPOSE 5555, 5556, 5557

CMD ["riemann-0.2.2/bin/riemann", "riemann-0.2.2/etc/riemann.config"]
