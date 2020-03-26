#@IgnoreInspection BashAddShebang  
# Jupyter Notebook with jupyter-scala  
# https://github.com/alexarchambault/jupyter-scala  
FROM java:8  
MAINTAINER Clay Graham <claytantor@gmail.com>  
  
ENV VERSION=0.3.0-M3  
ENV SCALA_VERSION=2.10.6  
ENV os.arch=x86_64  
ENV os.name=linux  
  
RUN apt-get update \  
&& apt-get install -y \  
curl \  
gradle \  
python3 \  
python3-pip \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip3 install jupyter  
  
RUN curl -L -o jupyter-scala-2.10 https://git.io/vzhR7 \  
&& chmod +x jupyter-scala-2.10 \  
&& ./jupyter-scala-2.10 \  
&& rm -f jupyter-scala-2.10  
  
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
  
ADD . /opt/app  
WORKDIR /opt/app  
RUN ./gradlew clean build copyDepJars  
RUN rm -rvf /root/.gradle/caches/modules-2  
  
EXPOSE 8888  
WORKDIR /opt/app/src/main/ipynb  
  
CMD ["/entrypoint.sh"]  

