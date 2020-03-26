FROM ubuntu:14.04  
  
ENV TEMPDIR=/tmp/build_mapguide  
ENV URL="http://download.osgeo.org/mapguide/releases/2.6.0/Release/ubuntu12"  
ENV FDOVER_MAJOR_MINOR=3.9  
ENV FDOVER_MAJOR_MINOR_REV=${FDOVER_MAJOR_MINOR}.0  
ENV FDOBUILD=7090  
ENV FDOARCH=i386  
ENV FDOVER=${FDOVER_MAJOR_MINOR_REV}-${FDOBUILD}_${FDOARCH}  
ENV MGVER_MAJOR_MINOR=2.6  
ENV MGVER_MAJOR_MINOR_REV=${MGVER_MAJOR_MINOR}.1  
ENV MGBUILD=8316  
ENV MGARCH=i386  
ENV MGVER=${MGVER_MAJOR_MINOR_REV}-${MGBUILD}_${MGARCH}  
  
ENV DEFAULT_ADMIN_PORT=2810  
ENV DEFAULT_CLIENT_PORT=2811  
ENV DEFAULT_SITE_PORT=2812  
  
ENV DEFAULT_HTTPD_PORT=8008  
ENV DEFAULT_TOMCAT_PORT=8009  
ENV MG_PATH=/usr/local/mapguideopensource-${MGVER_MAJOR_MINOR_REV}  
  
RUN dpkg --add-architecture i386  
RUN apt-get update && apt-get install -y --no-install-recommends\  
wget \  
default-jre \  
libpcre3:i386 \  
libexpat1:i386 \  
odbcinst:i386 \  
unixodbc:i386 \  
libstdc++6:i386 \  
libcurl3:i386 \  
libxslt1.1:i386 \  
libpng12-0:i386; \  
rm -rf /var/lib/apt/lists/*; \  
rm -rf /var/lib/apt/archives/*  
  
  
COPY mginstall.sh /tmp/mginstall.sh  
  
RUN chmod +x /tmp/mginstall.sh; \  
/tmp/mginstall.sh --headless \  
\--with-sdf \  
\--width-shp \  
\--with-sqlite \  
\--with-gdal \  
\--with-ogr \  
\--with-kingoracle \  
\--with-wfs \  
\--with-wms;  
  
RUN apt-get update && apt-get -f install -y;\  
rm -rf /var/lib/apt/lists/*; \  
rm -rf /var/lib/apt/archives/*  
  
WORKDIR ${MG_PATH}  
  
RUN chmod 777 webserverextensions/www/TempDir; \  
chmod a+rw webserverextensions/www/fusion/lib/tcpdf/cache  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
EXPOSE 8008 8009  
  
ENTRYPOINT [ "/entrypoint.sh" ]  
  

