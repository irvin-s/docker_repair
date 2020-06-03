FROM python:3.4  
MAINTAINER Levi Bostian <levi@curiosityio.com>  
  
# Install dependencies  
RUN \  
apt-get update -qq && \  
apt-get install -y netcat && \  
rm -rf /var/lib/apt/lists/* && \  
pip install circus gunicorn taiga-contrib-gogs taiga-contrib-slack  
  
# Install taiga-back  
RUN \  
mkdir -p /usr/local/taiga && \  
useradd -d /usr/local/taiga taiga && \  
mkdir /usr/local/taiga/media /usr/local/taiga/static /usr/local/taiga/logs  
  
COPY taiga-back/ /usr/local/taiga/taiga-back  
  
RUN \  
cd /usr/local/taiga/taiga-back && \  
pip install -r requirements.txt && \  
touch /usr/local/taiga/taiga-back/settings/dockerenv.py && \  
touch /usr/local/taiga/circus.ini  
  
# Add Taiga Configuration  
ADD ./local.py /usr/local/taiga/taiga-back/settings/local.py  
  
# Configure and Start scripts  
COPY checkdb.py /checkdb.py  
ADD ./configure /usr/local/taiga/configure  
ADD ./start /usr/local/taiga/start  
RUN chmod +x /usr/local/taiga/configure /usr/local/taiga/start  
  
VOLUME /usr/local/taiga/media  
VOLUME /usr/local/taiga/static  
VOLUME /usr/local/taiga/logs  
  
ENV TAIGA_DB_NAME taiga  
ENV TAIGA_DB_USER postgres  
ENV TAIGA_DB_HOST postgres  
  
EXPOSE 8000  
CMD ["/usr/local/taiga/start"]  

