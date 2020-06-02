FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y wget
RUN wget https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_0.10.0_amd64.deb
RUN dpkg -i chronograf_0.10.0_amd64.deb

ADD ./chronograf.toml /chronograf.toml

EXPOSE 10000

CMD ["/opt/chronograf/chronograf", "-config=/chronograf.toml"]
