############################################################  
# Dockerfile to create GeoLite2 Country and City databases  
# with automatic weekly updates.  
#  
# Adapted from tkrs/maxmind-lite2-db and  
# tkrs/maxmind-geoipupdate by Takeru Sato.  
############################################################  
  
FROM alpine:3.5  
  
MAINTAINER Leila Hadj-Chikh <leila.hadj-chikh@dunbarsecured.com>  
  
  
### DOWNLOAD DATABASES  
  
ENV GEOIP_BASE_URL http://geolite.maxmind.com/download/geoip/database  
ENV GEOIP_CNTR_DB GeoLite2-Country.mmdb  
ENV GEOIP_CITY_DB GeoLite2-City.mmdb  
ENV GEOIP_DB_DIR /usr/share/GeoIP  
  
# download gzip database files to /tmp/  
ADD ${GEOIP_BASE_URL}/${GEOIP_CNTR_DB}.gz /tmp/  
ADD ${GEOIP_BASE_URL}/${GEOIP_CITY_DB}.gz /tmp/  
  
# unzip databases into database directory  
RUN mkdir -p ${GEOIP_DB_DIR} \  
&& gunzip -c /tmp/${GEOIP_CNTR_DB}.gz > ${GEOIP_DB_DIR}/${GEOIP_CNTR_DB} \  
&& gunzip -c /tmp/${GEOIP_CITY_DB}.gz > ${GEOIP_DB_DIR}/${GEOIP_CITY_DB} \  
&& rm -f /tmp/GeoLite2-*  
  
VOLUME ${GEOIP_DB_DIR}  
  
  
### INSTALL GEOIPUPDATE  
  
# copy geoipupdate settings  
COPY GeoIP.conf /usr/etc/GeoIP.conf  
  
# install geoipupdate  
RUN BUILD_DEPS='gcc make libc-dev libtool automake autoconf git' \  
&& apk --no-cache add curl-dev ${BUILD_DEPS} \  
&& git clone https://github.com/maxmind/geoipupdate /tmp/geoipupdate \  
&& cd /tmp/geoipupdate \  
&& ./bootstrap \  
&& ./configure --prefix=/usr \  
&& make \  
&& make install \  
&& cd \  
&& apk del --purge ${BUILD_DEPS} \  
&& rm -rf /var/cache/apk/* \  
&& rm -rf /tmp/geoipupdate  
  
  
### CONFIGURE AUTOMATIC UPDATES  
  
# copy crontab for running updates  
COPY cronfile /var/spool/cron/crontabs/root  
  
# run crond in foreground  
ENTRYPOINT ["crond", "-f"]  
  
# set crond options: log to stderr with log level 8  
CMD ["-d", "8"]  

