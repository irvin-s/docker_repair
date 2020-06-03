FROM java:7
MAINTAINER Justin Littman <justinlittman@gwu.edu>

RUN apt-get update && apt-get install -y \
    ant
WORKDIR /tmp
RUN wget http://sourceforge.net/projects/vivo/files/VIVO%20Application%20Source/vivo-rel-1.7.zip/download
RUN mv download vivo-rel-1.7.zip
RUN unzip vivo-rel-1.7.zip
WORKDIR /tmp/vivo-rel-1.7
ADD build.properties /tmp/vivo-rel-1.7/
VOLUME ["/usr/local/tomcat/webapps","/usr/local/vivo/home"]
RUN ant compile
#Only build if not already built to avoid overwriting
#To force a build, delete runtime.properties.
CMD [ ! -f /usr/local/vivo/home/runtime.properties ] \
    && ant deploy \
    && chmod ugo+w -R /usr/local/vivo/home \
    && cp /usr/local/vivo/home/example.runtime.properties /usr/local/vivo/home/runtime.properties
