##########################################################################  
FROM cineca/icat  
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@cineca.it>"  
# ##########################################################################  
USER root  
ENV RESOURCES_DIR /opt/irods_res  
ENV MAINRES_DIR $RESOURCES_DIR/main  
ENV REPLICA_DIR $RESOURCES_DIR/replicas  
# RUN mkdir -p $MAINRES_DIR $REPLICA_DIR \  
# && chown -R $IRODS_USER:$IRODS_USER $RESOURCES_DIR  
ENV MAINRES myResc  
ENV REPLICARES replicaResc  
ENV HANDLECONF /myconfig  
RUN echo "# HANDLE CONFIGURATION" > $HANDLECONF  
  
# ##########################################################################  
# DON'T BECAUSE FUTURE INSTALLATION SCRIPT WAIT FOR FILES THERE TO WORK  
# # Clean tmp  
# RUN rm -rf /tmp/*  
# ##########################################################################  
# Install dependencies for EUDAT python scripts  
RUN apt-get update && apt-get install -y \  
python-setuptools python-dev build-essential \  
libxml2-dev libxslt1-dev libz-dev \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* \  
&& easy_install pip && pip install --upgrade pip \  
&& pip install simplejson httplib2 defusedxml lxml queuelib dweepy  
  
# ##########################################################################  
# Clone eudat repo  
USER $IRODS_USER  
RUN cd /tmp && git clone https://github.com/EUDAT-B2SAFE/B2SAFE-core  
WORKDIR /tmp/B2SAFE-core/packaging  
RUN ./create_deb_package.sh  
# Move from home dir, which will become a volume and clean everything  
RUN mv /home/$IRODS_USER/debbuild/irods* /tmp/  
# Inside the first time install script we must install the package  
# ##########################################################################  
# Prepare install script  
ENV EUDAT_CONFIGF /tmp/eudat.conf  
ADD myeudat.conf $EUDAT_CONFIGF  
ADD install_eudat.sh $EXTRA_INSTALLATION_SCRIPT  
# Go home  
WORKDIR /home/$IRODS_USER  
  
# # Save resources and eudat configurations?  
# VOLUME /opt  

