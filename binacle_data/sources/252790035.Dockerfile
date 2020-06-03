FROM python:alpine  
MAINTAINER Yusuke Miyazaki <miyazaki.dev@gmail.com>  
  
COPY . /app/  
WORKDIR /app  
  
RUN set -ex \  
&& apk add --no-cache --virtual .build-deps \  
bash \  
gcc \  
g++ \  
libc-dev \  
make \  
ncurses-dev \  
readline-dev \  
&& pip install -r requirements.txt \  
&& runDeps="$( \  
scanelf --needed --nobanner --recursive /usr/local \  
| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \  
| sort -u \  
| xargs -r apk info --installed \  
| sort -u \  
)" \  
&& apk add --virtual .rundeps $runDeps \  
&& apk del .build-deps \  
&& rm -rf /root/.cache  
  
RUN mkdir -p -m 700 /root/.jupyter/ && \  
echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py  
  
EXPOSE 8888  
CMD ["jupyter", "notebook"]  

