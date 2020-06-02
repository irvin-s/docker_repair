FROM caesar0301/catalog_builder:latest  
  
MAINTAINER Xiaming Chen <chenxm35@gmail.com>  
  
ENV CATALOG_HOME=/usr/lib/catalog  
ENV CATALOG_LOG_DIR=/var/log/catalog  
ENV CATALOG_TMP=/tmp/catalog  
ENV CATALOG_WEBSERVER_PORT=4444  
# Install dependencies  
RUN apt-get update  
RUN apt-get install -y libmysqlclient-dev python-pip  
  
WORKDIR $CATALOG_HOME  
  
# Fetch latest source code  
RUN rm -rf $CATALOG_TMP \  
&& git clone http://github.com/awesomedata/catalog.git $CATALOG_TMP  
  
RUN pip install -U -r $CATALOG_TMP/requirements.txt  
# RUN cd $CATALOG_TMP && python setup.py install  
RUN cp -r $CATALOG_TMP/docker/scripts $CATALOG_HOME/scripts  
RUN cp -r $CATALOG_TMP/migrations $CATALOG_HOME/migrations  
RUN cp -r $CATALOG_TMP/catalog $CATALOG_HOME/catalog  
RUN cp -r $CATALOG_TMP/docs $CATALOG_HOME/docs  
RUN cp -r $CATALOG_TMP/tasks $CATALOG_HOME/tasks  
RUN cp -r $CATALOG_TMP/bin/catalog $CATALOG_HOME/scripts/  
RUN cp -r $CATALOG_TMP/requirements.txt $CATALOG_HOME/  
RUN cp -r $CATALOG_TMP/LICENSE $CATALOG_HOME/  
RUN cp -r $CATALOG_TMP/README.md $CATALOG_HOME/  
  
# Clear temporary files  
RUN rm -rf $CATALOG_TMP  
  
# Logging file directory  
RUN mkdir -p $CATALOG_LOG_DIR  
RUN chmod -R 777 $CATALOG_LOG_DIR  
  
# Make binaries executable and add to global PATH  
RUN chmod +x $CATALOG_HOME/scripts/*  
ENV PATH $PATH:$CATALOG_HOME/scripts/  
  
EXPOSE $CATALOG_WEBSERVER_PORT  

