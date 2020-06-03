FROM ubuntu:14.04
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yq install wget
RUN wget -O /opt/splunk-6.1.3-220630-linux-2.6-amd64.deb 'http://www.splunk.com/page/download_track?file=6.1.3/splunk/linux/splunk-6.1.3-220630-linux-2.6-amd64.deb&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.1.3&product=splunk&typed=release' \
  && dpkg -i /opt/splunk-6.1.3-220630-linux-2.6-amd64.deb \
  && rm /opt/splunk-6.1.3-220630-linux-2.6-amd64.deb
RUN /opt/splunk/bin/splunk enable boot-start --accept-license
RUN chmod 755 /etc/init.d/splunk && chown -R splunk:splunk /opt/splunk
EXPOSE 8000
EXPOSE 8089
EXPOSE 9997
ADD start.sh /usr/local/bin/start.sh
CMD /usr/local/bin/start.sh
