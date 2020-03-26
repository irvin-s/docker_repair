FROM debian:8.9  
  
MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>  
  
################  
# Dependencies #  
################  
  
# basic packages  
RUN apt-get update && apt-get install -y \  
git python-dev wget \  
librdf0 librdf0-dev python-librdf \  
python-setuptools \  
python-pip  
  
###############  
# Application #  
###############  
  
# lodstats_www  
RUN apt-get install -y libpq-dev  
RUN git clone https://github.com/AKSW/LODStats_WWW /lodstats_www  
RUN cd /lodstats_www && pip install --pre -r requirements.txt  
  
RUN cd /lodstats_www && python setup.py egg_info  
RUN cd /lodstats_www && paster make-config rdfstats production.ini  
RUN sed -i s/REPLACE_WITH_PASSWORD/lodstats/g /lodstats_www/production.ini  
  
# lodstats  
RUN git clone https://github.com/AKSW/LODStats /lodstats  
RUN cd /lodstats && python setup.py install  
  
# csv2rdf  
RUN git clone https://github.com/AKSW/CSV2RDF-WIKI /csv2rdf-wiki  
ENV PYTHONPATH /lodstats_www:/csv2rdf-wiki  
RUN cp /lodstats_www/production.ini /production.ini  
  
###########  
# VOLUMES #  
###########  
  
VOLUME ["/lodstats"]  
VOLUME ["/lodstats_www"]  
VOLUME ["/csv2rdf-wiki"]  
  
ADD start_processing.sh /start_processing.sh  
RUN chmod +x /start_processing.sh  
  
WORKDIR /lodstats_www  
  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
CMD ["/bin/bash", "/start.sh"]  
  
EXPOSE 80  

