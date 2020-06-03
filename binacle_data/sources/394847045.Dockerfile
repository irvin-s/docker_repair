# Datomic Free v0.9.4699
#
# It's public image to run datomic database on docker container.

FROM dockerfile/java
MAINTAINER Timo Sulg, timo@tauho.com

#-- INSTALL PREREQURIEMENTS
#update package manager
RUN sudo apt-get -y update

# install curl
RUN sudo apt-get install -y curl
# install unzip
RUN sudo apt-get install -y unzip

#initialise global variables
ENV DATOMIC_VERSION 0.9.4699
ENV DATOMIC_HOME /home/docker/datomic
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV PATH $JAVA_HOME:/bin:/usr/bin:$PATH

#-- SETUP DATOMIC
# create required folders
RUN mkdir ~/temp
RUN mkdir ~/datomic
RUN mkdir ~/datomic_configs

# download source
RUN echo Downloading version ${DATOMIC_VERSION}
RUN curl --progress-bar --location\
 --user-agent 'tauhoDB (info@tauho.db)'\
 --url "https://my.datomic.com/downloads/free/${DATOMIC_VERSION}"\
 --output ~/temp/datomic.zip

# unzip datomic
RUN unzip -u ~/temp/datomic.zip -d ~/temp

#move unzipped files into own folder and remove temp folder
RUN cp -r ~/temp/datomic-free-${DATOMIC_VERSION}/* ~/datomic
RUN rm -r ~/temp

#-- MOUNT Volumes
# mount  data folder on host
#VOLUME [/datomic_configs, /root/datomic_data]

#-- IMPORT transactor file from vagrant HOST into container
#ADD /datomic_configs/ /root/datomic_configs/

#-- RUN DATOMIC
# copy default transactor into datomic root
RUN cp ~/datomic/config/samples/free-transactor-template.properties ~/datomic/free-transactor.properties

# modify url in transactor file
RUN sed "s/host=localhost/host=0.0.0.0/" -i ~/datomic/free-transactor.properties

# -- execute free transactor with updated settings
CMD ["/root/datomic/bin/transactor", "/root/datomic/free-transactor.properties"]
EXPOSE 4334

