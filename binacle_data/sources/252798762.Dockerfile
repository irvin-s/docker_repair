FROM python:3.4-slim  
  
MAINTAINER Alberto Martín <alberto.martin@bitergia.com>  
  
ENV GIT_URL_PERCEVAL https://github.com/vwangler/perceval.git  
ENV GIT_REV_PERCEVAL pulls  
  
# install dependencies  
RUN apt-get update && \  
apt-get install -y build-essential git --no-install-recommends && \  
git clone \--depth 1 ${GIT_URL_PERCEVAL} -b ${GIT_REV_PERCEVAL} && \  
pip install -r perceval/requirements.txt perceval/ && \  
apt-get clean && \  
apt-get autoremove --purge -y && \  
find /var/lib/apt/lists -type f -delete  
  
ENTRYPOINT ["/usr/local/bin/perceval"]  

