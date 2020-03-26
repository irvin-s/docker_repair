FROM jboss/wildfly:10.1.0.Final

ADD infinispan-visualizer.war /opt/jboss/wildfly/standalone/deployments/

CMD ["/opt/jboss/wildfly/bin/standalone.sh", \
  "-b", "0.0.0.0", \
  "-Dinfinispan.visualizer.jmxUser=developer", \
  "-Dinfinispan.visualizer.jmxPass=developer", \
  "-Dinfinispan.visualizer.serverList=datagrid-hotrod:11222"]
