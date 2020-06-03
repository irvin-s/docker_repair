FROM ubuntu:14.04  
MAINTAINER Diffeo <support@diffeo.com>  
  
RUN apt-get update -y && apt-get install -y python python-pip  
  
RUN apt-get install -y \  
make libz-dev libxslt1-dev libxml2-dev python-dev \  
python-virtualenv g++ xz-utils gfortran liblzma-dev \  
libpq-dev libfreetype6-dev libblas-dev liblapack-dev \  
libboost-python-dev libsnappy1 libsnappy-dev \  
libjpeg-dev zlib1g-dev libpng12-dev git \  
ssh  
  
# We could install these with `pip`, but this is so much faster.  
RUN apt-get install -y \  
python-numpy python-scipy python-sklearn python-matplotlib \  
python-gevent uwsgi  
  
# Download and install the NLTK corpus.  
RUN pip install nltk \  
&& python -m nltk.downloader -d /usr/share/nltk_data all  
  
# Upgrade pip.  
RUN pip install --upgrade pip  
  
# Install psycopg2 in case we want a postgres backend.  
RUN pip install psycopg2  
  
# There is a bug in our pairwise model code that can result in passing a  
# NaN to the sklearn model training. In old versions, this causes the model  
# to raise an exception. In newer versions, it emits a warning and keeps on  
# chugging. So we upgrade! ---AG  
RUN pip install --upgrade scikit-learn  
  
# Blech. PyPI is misbehaving, so we have to check out some repos and build  
# from source.  
RUN cd /tmp && git clone git://github.com/dossier/dossier.label \  
&& cd /tmp/dossier.label && pip install . \  
&& cd /tmp && git clone git://github.com/dossier/dossier.web \  
&& cd /tmp/dossier.web && pip install .  
  
# Now install dossier.models.  
RUN pip install --pre 'dossier.models>=0.6.9'  
  
ADD config.yaml /config.yaml  
ADD background-50000.tfidf.gz /  
RUN gunzip /background-50000.tfidf.gz  
  
RUN rm -f /etc/service/sshd/down  
ADD ssh_login.pub /tmp/ssh_login.pub  
RUN mkdir -p /root/.ssh \  
&& cat /tmp/ssh_login.pub >> /root/.ssh/authorized_keys \  
&& rm -f /tmp/ssh_login.pub  
  
ADD run.sh /run.sh  
RUN chmod +x /run.sh  
  
# Finally, run the dossier.models web server.  
ENV PROCESSES 4  
EXPOSE 57312  
CMD /run.sh uwsgi \  
\--http-socket 0.0.0.0:57312 \  
\--wsgi dossier.models.web.wsgi \  
\--pyargv "-c /config.yaml" \  
\--master \  
\--processes $PROCESSES \  
\--vacuum \  
\--max-requests 5000  

