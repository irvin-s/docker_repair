FROM tomcat:8.0  
LABEL authors="Nathan S. Watson-Haigh, Radoslaw Suchecki"  
  
ENV POTAGE_APP_CODE /opt/potage  
ENV POTAGE_DATA_DIR /var/tomcat/persist/potage_data  
  
# install system-wide deps  
RUN apt-get update && apt-get install -y \  
ant \  
make \  
ncbi-blast+ \  
openjdk-7-jdk \  
&& rm -rf /var/lib/apt/lists/*  
  
# Copy the application code  
COPY potage ${POTAGE_APP_CODE}  
  
# Build POTAGE using a custom build file  
COPY build.xml ${POTAGE_APP_CODE}/  
WORKDIR ${POTAGE_APP_CODE}  
RUN ant  
  
# Deploy POTAGE webapp  
RUN mv ${POTAGE_APP_CODE}/dist/potage.war /usr/local/tomcat/webapps/  
  
# Setup POTAGE data directory  
COPY potage_data ${POTAGE_DATA_DIR}  
  
# Add directory containing the BLAST DB setup script to PATH  
ENV PATH ${POTAGE_DATA_DIR}:$PATH  
WORKDIR ${POTAGE_DATA_DIR}  
  
# expose port  
EXPOSE 8080  
# start app  
CMD [ "catalina.sh", "run" ]  

