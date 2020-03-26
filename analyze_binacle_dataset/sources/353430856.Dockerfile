FROM centos:latest

#Update packages and get minimum necessary tools
#RUN yum -y update && yum -y install wget unzip nc
RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf && \ 
    yum -y install wget unzip nc 

#Get latest supported Java, Install and Cleanup
RUN wget --no-cookies \
         --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm" \
         -O /tmp/jdk-7u79-linux-x64.rpm && \
         rpm -ihv /tmp/jdk-7u79-linux-x64.rpm && \
         rm /tmp/jdk-7u79-linux-x64.rpm


## Hybris Media ##
## If you dont already have the media locally, uncomment the WGET RUN and comment out the COPY stanza.
## Get Hybris Media from Wiki Online
#RUN wget --http-user=@HYBRIS_WIKI_USER@ \
#         --http-password='@HYBRIS_WIKI_PASS@' \
#         -O /tmp/hybris-commerce-suite-5.4.0.4.zip \
#         https://download.hybris.com/resources/releases/5.4.0/hybris-commerce-suite-5.4.0.4.zip 

## Pull Hybris Media in from local path ##
COPY hybris-commerce-suite-5.4.0.4.zip /tmp/

## Create directory and unpack Media ##
RUN mkdir -p /opt/hybris/5.4.0.4 && \
    ln -s /opt/hybris/5.4.0.4 /opt/hybris/current && \
    unzip /tmp/hybris-commerce-suite-5.4.0.4.zip -d /opt/hybris/current && \
    rm /tmp/hybris-commerce-suite-*.zip

## Run Initial Ant ##
RUN cd /opt/hybris/current/hybris/bin/platform && \
    . ./setantenv.sh && \
    #Wait for unzip to release ant
    sleep 1 && \
    yes  | ant

## Copy in License File##
#NOTE: You must overwrite the hybrislicence.jar in this repo with your license, otherwise the demo license will be used.
COPY conf/hybrislicence.jar /opt/hybris/current/hybris/config/license/hybrislicence.jar

## Copy templatized common local.properties ##
COPY conf/local.properties /opt/hybris/current/hybris/config/

## Copy hybris-wrapper to configure template properties at runtime ##
COPY bin/hybris-wrapper.sh /opt/hybris/current/hybris/bin/platform/

## Code-Sync Placeholder ##
## RUN some git clone overlay process of projects custom code into hybris dir ##

## Set necessary template parameters as ENV vars ## 
ENV HYB-JAVA-XMX=2g HYB-JAVA-XMS=2g HYB-JAVA-PERM=512m HYB-JAVA-MAXPERM=512m HYB-JAVA-GCLOGPTH=/opt/hybris/current/hybris/log/tomcat/hybris-gc.log HYB-JAVA-NUMGCLOGS=5 HYB-JAVA-MAXGCLOGSZ=100M HYB-APM-JAVAAGENT="" 
ENV HYB-JDBC-URL=jdbc:hsqldb:file:${HYBRIS_DATA_DIR}/hsqldb/mydb;shutdown=true;hsqldb.cache_rows=100000;hsqldb.cache_size=20000;hsqldb.write_delay_millis=1000;hsqldb.inc_backup=true;hsqldb.defrag_limit=2;hsqldb.nio_data_file=false
ENV HYB-JDBC-DRIVER=org.hsqldb.jdbcDriver HYB-DB-USER=sa HYB-DB-PASS=""  
 
## Expose AJP S-AJP HTTP HTTPS RMI ports ##
EXPOSE 8009 8010 9001 9002 1099

## Set Wrapper Entrypoint script to replace template vars, populate them, and start the server ##
ENTRYPOINT ["/opt/hybris/current/hybris/bin/platform/hybris-wrapper.sh"]

