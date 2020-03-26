FROM azul/zulu-openjdk-debian  
  
RUN apt-get update && apt-get install -y graphviz wget  
  
RUN wget -O /opt/schemaSpy.jar \  
https://github.com/schemaspy/schemaspy/releases/download/v6.0.0-rc1/schemaspy-6.0.0-rc1.jar  
  
RUN wget -O /opt/postgresql-jdbc4.jar \  
https://jdbc.postgresql.org/download/postgresql-9.4-1201.jdbc4.jar  
  
COPY run.sh /usr/local/bin/spy  
COPY spy.conf /opt/schemaspy.properties  
  

