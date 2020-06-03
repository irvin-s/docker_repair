FROM area51/postgresql:9.6  
MAINTAINER Peter Mount <peter@retep.org>  
  
#============================================================================  
# To determine these:  
# docker run -it --rm postgres:9.5 bash  
# apt-get update  
# apt-cache search postgis  
# That will give you POSTGIS_MAJOR.  
#  
# So if it's 2.2 then: apt-cache show postgresql-9.5-postgis-2.2|grep Version  
# Will give you the POSTGIS_VERSION  
#============================================================================  
ENV POSTGIS_MAJOR 2.3  
ENV POSTGIS_VERSION 2.3.2+dfsg-1~exp2.pgdg80+1  
COPY *.sh /docker-entrypoint-initdb.d/  
  
RUN apt-get update &&\  
apt-get install -y --no-install-recommends \  
vim \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \  
postgis=$POSTGIS_VERSION &&\  
rm -rf /var/lib/apt/lists/*  
  

