# vim: set ft=dockerfile:  
FROM ubuntu:trusty  
# Author with no obligation to maintain  
MAINTAINER Paul Tötterman <paul.totterman@iki.fi>  
  
ENV DEBIAN_FRONTEND="noninteractive" \  
RATTIC_URL="https://github.com/tildaslash/RatticWeb/archive/v1.3.1.tar.gz" \  
# possible configs for rattic, check out entrypoint.sh  
TIMEZONE="" \  
SECRETKEY="" \  
DEBUG="" \  
LOGLEVEL="" \  
HOSTNAME="" \  
PASSWORD_EXPIRY_DAYS="" \  
DB_HOSTNAME="" \  
DB_PORT="" \  
DB_DBNAME="" \  
DB_USERNAME="" \  
DB_PASSWORD="" \  
LDAP_URI="" \  
LDAP_STARTTLS="" \  
LDAP_REQCERT="" \  
LDAP_BINDDN="" \  
LDAP_BINDPW="" \  
LDAP_BASE="" \  
LDAP_USERBASE="" \  
LDAP_USERFILTER="" \  
LDAP_GROUPBASE="" \  
LDAP_GROUPFILTER="" \  
LDAP_GROUPTYPE="" \  
LDAP_USERFIRSTNAME="" \  
LDAP_USERLASTNAME="" \  
LDAP_STAFFDN=""  
  
COPY 00InstallRecommends /etc/apt/apt.conf.d/00InstallRecommends  
RUN apt-get -q update && \  
apt-get -qq install \  
build-essential \  
ca-certificates \  
curl \  
gettext \  
libjs-jquery \  
mysql-client \  
libmysqlclient-dev \  
python \  
python-crypto \  
python-dev \  
python-django \  
python-django-auth-ldap \  
python-ldap \  
python-lxml \  
python-markdown \  
python-mimeparse \  
python-mysqldb \  
python-pip \  
python-pyasn1 \  
zlib1g-dev && \  
apt-get clean && \  
rm -f /var/lib/apt/lists/*_* && \  
curl -sSL -o /opt/rattic.tar.gz "${RATTIC_URL}" && \  
mkdir -p /opt/rattic && \  
tar xzCf /opt/rattic /opt/rattic.tar.gz --strip-components=1 && \  
rm -f /opt/rattic.tar.gz && \  
cd /opt/rattic && \  
mkdir static && \  
pip install -r requirements-mysql.txt && \  
pip install gunicorn && \  
cd /usr/local/lib/python2.7/dist-packages && \  
rm -rf djcelery/migrations kombu/transport/django/migrations && \  
mv djcelery/south_migrations djcelery/migrations && \  
mv kombu/transport/django/south_migrations kombu/transport/django/migrations  
  
COPY minimal.cfg /opt/rattic/conf/local.cfg  
RUN cd /opt/rattic && \  
./manage.py collectstatic -c --noinput && \  
./manage.py compilemessages  
  
COPY entrypoint.sh /  
  
VOLUME /opt/rattic/static  
EXPOSE 8000  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["serve"]  

