FROM fedora:latest  
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>  
  
RUN yum -y install \  
deltarpm pwgen supervisor \  
postgresql postgresql-server postgresql-contrib  
RUN yum -y update && yum -y clean all  
  
ENV PGHOME=/var/lib/pgsql  
ENV PGDATA=${PGHOME}/data  
ENV PGPORT=5432  
ENV PGSHARE=/usr/share/pgsql  
ENV POST_INIT=/usr/share/pgsql-post-init  
  
ADD assets/supervisord.conf /etc/supervisord.conf  
ADD assets/pgsql-server-start /bin/pgsql-server-start  
ADD assets/pgsql-post-init/ ${POST_INIT}  
  
USER postgres  
WORKDIR ${PGHOME}  
  
# ensure the home directory is clean to trigger initdb on first boot  
RUN rm -rf ${PGHOME}/*  
  
VOLUME ["${PGHOME}", "${POST_INIT}"]  
EXPOSE ${PGPORT}  
  
CMD ["/usr/bin/supervisord", "-n"]  

