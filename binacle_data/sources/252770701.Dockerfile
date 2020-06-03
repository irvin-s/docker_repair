FROM python:2.7.8-wheezy  
  
MAINTAINER Crystale Afflick  
  
RUN apt-get update -qq && apt-get install -y build-essential\  
git-core\  
libldap2-dev\  
libpq-dev\  
libsasl2-dev\  
libssl-dev\  
libxml2-dev\  
libxslt1-dev\  
libffi-dev\  
python-dev\  
python-setuptools\  
zlib1g-dev\  
postgresql-client  
# Python dependencies  
RUN pip install "Django>=1.5,<1.6"  
RUN pip install "avocado>=2.3.0,<2.4"  
RUN pip install "serrano>=2.3.0,<2.4"  
RUN pip install "modeltree>=1.1.7,<1.2"  
RUN pip install "django-haystack==2.0.0"  
RUN pip install "python-memcached==1.53"  
RUN pip install "psycopg2"  
RUN pip install "whoosh==2.4.1"  
RUN pip install "openpyxl"  
  
# Add application files  
RUN mkdir /opt/app  
ADD . /opt/app/  
  
ENV APP_NAME openmrs  
ENV APP_ENV test  
  
# Ensure all python requirements are met  
RUN pip install -r /opt/app/requirements.txt  
  
EXPOSE 8000  
CMD ["/opt/app/scripts/run.sh"]  

