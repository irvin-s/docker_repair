FROM java:7
MAINTAINER Justin Littman <justinlittman@gwu.edu>

RUN apt-get update && apt-get install -y \
    ant
WORKDIR /tmp
#Getting VIVO separately from VITRO
RUN wget https://github.com/vivo-project/VIVO/archive/rel-1.8.zip
RUN unzip rel-1.8*.zip
RUN wget https://github.com/vivo-project/Vitro/archive/rel-1.8.zip
RUN unzip rel-1.8*.zip.1
RUN mv VIVO-rel-1.8 VIVO-rel
RUN mv Vitro-rel-1.8 VIVO-rel/vitro-core
WORKDIR /tmp/VIVO-rel
ADD build.properties /tmp/VIVO-rel/
VOLUME ["/usr/local/tomcat/webapps","/usr/local/vivo/home"]
RUN ant compile
#Only build if not already built to avoid overwriting
#To force a build, delete runtime.properties.
CMD [ ! -f /usr/local/vivo/home/runtime.properties ] \
    && ant deploy \
    && chmod ugo+w -R /usr/local/vivo/home \
    && cp /usr/local/vivo/home/config/example.applicationSetup.n3 /usr/local/vivo/home/config/applicationSetup.n3 \
    && cp /usr/local/vivo/home/example.runtime.properties /usr/local/vivo/home/runtime.properties
