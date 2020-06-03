FROM debian:jessie

MAINTAINER aviad@perimeterx.com

RUN apt-get update
RUN apt-get install -y --no-install-recommends git ca-certificates libtool m4 autoconf automake libjansson-dev libssl-dev libcurl4-openssl-dev apache2-dev apache2

WORKDIR tmp
RUN git clone https://github.com/PerimeterX/mod_perimeterx.git mod_perimeterx
RUN cd mod_perimeterx && sh autogen.sh && ./configure && make clean && make && make install

EXPOSE 80

#Make sure you have your perimeterx.conf in the build directory
ADD perimeterx.conf /etc/apache2/mods-available/perimeterx.conf
RUN ln -s /etc/apache2/mods-available/perimeterx.conf /etc/apache2/mods-enabled/
CMD ["apachectl", "-f", "/etc/apache2/apache2.conf", "-e", "debug", "-DFOREGROUND"]
