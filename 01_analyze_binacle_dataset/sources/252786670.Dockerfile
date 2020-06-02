# Jupyter Notebook with jupyter-scala  
# https://github.com/alexarchambault/jupyter-scala  
FROM java:7  
MAINTAINER Yeongho Kim <yeonghoey@gmail.com>  
  
RUN apt-get update \  
&& apt-get install -y \  
curl \  
python3 \  
python3-pip \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip3 install jupyter  
  
RUN curl -L -o jupyter-scala https://git.io/vzhRi \  
&& chmod +x jupyter-scala \  
&& ./jupyter-scala \  
&& rm -f jupyter-scala  
  
ENV NBCONFIG /root/.jupyter/nbconfig  
RUN mkdir -p $NBCONFIG \  
&& { echo '{"CodeCell":{"cm_config":'; \  
echo '{"indentUnit":2,"smartIndent":false}'; \  
echo '}}'; \  
} > /$NBCONFIG/notebook.json  
  
COPY bootstrap.py /bootstrap.py  
RUN { echo '#!/bin/bash'; \  
echo 'set -e'; \  
echo 'python3 /bootstrap.py'; \  
echo 'jupyter notebook'; \  
} > /entrypoint.sh \  
&& chmod +x /entrypoint.sh  
  
VOLUME /notebooks  
WORKDIR /notebooks  
EXPOSE 8888  
CMD ["/entrypoint.sh"]

