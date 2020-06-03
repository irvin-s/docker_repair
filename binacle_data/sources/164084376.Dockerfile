FROM ubuntu:14.04
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>
RUN apt-get -qqy update
RUN apt-get install -y -q r-base r-base-dev gdebi-core libapparmor1 supervisor wget
RUN (wget http://download2.rstudio.org/rstudio-server-0.98.978-amd64.deb && gdebi -n rstudio-server-0.98.978-amd64.deb)
RUN rm /rstudio-server-0.98.978-amd64.deb
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787
CMD ["/usr/bin/supervisord"]
