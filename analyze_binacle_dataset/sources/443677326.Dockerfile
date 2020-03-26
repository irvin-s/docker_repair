FROM codingtony/java

MAINTAINER tony.bussieres@ticksmith.com

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install unzip -y
# this bitly link is the one on the Artifactory Download page http://www.jfrog.com/home/v_artifactory_opensource_download
RUN wget --content-disposition http://bit.ly/Hqv9aj 
RUN cd /opt && unzip ~/artifactory-3.3.0.zip
RUN mv /opt/artifactory-3.3.0 /opt/artifactory
RUN rm ~/artifactory-3.3.0.zip
RUN mkdir /opt/artifactory/data

EXPOSE 8081

CMD [ "/opt/artifactory/bin/artifactory.sh" ]

