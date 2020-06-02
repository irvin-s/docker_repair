FROM python:3.5  
  
RUN apt-get update && apt-get install -y \  
libcairo2-dev \  
libjpeg62-turbo-dev \  
libpango1.0-dev \  
libgif-dev \  
build-essential \  
\--no-install-recommends \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY scripts/run.sh /data/  
COPY scripts/install-modules.sh /data/  
  
COPY vendor/ /data/.evennode/  
  
RUN set -ex \  
&& groupadd -g 2567 app \  
&& useradd -rm -u 2567 -g app app \  
\  
&& mkdir -p /data/app \  
\  
&& chmod u+x /data/*.sh \  
&& chmod u+x /data/.evennode/pip-pop/pip-grep \  
\  
&& chown -R app:app /data

