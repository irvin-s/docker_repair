FROM java:8

EXPOSE 1337 1338/udp 5701

RUN mkdir /app
ADD target/universal/loraley-1.0.zip /tmp/loraley.zip
RUN unzip /tmp/loraley.zip -d /app

WORKDIR /app/loraley-1.0

#RUN sed -e "s/\${host}/${host_ip}/" /app/loraley-1.0/${conf}

CMD /app/loraley-1.0/bin/loraley ${conf}

