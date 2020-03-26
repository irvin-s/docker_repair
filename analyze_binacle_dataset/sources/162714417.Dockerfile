FROM jetty
ADD docker-env/preprod-nextprot-application.properties /home/jetty/.config/nextprot-application.properties
RUN wget "http://miniwatt.isb-sib.ch:8800/nexus/service/local/repositories/nextprot-repo/content/org/nextprot/nextprot-api-web/2.10.2/nextprot-api-web-2.10.2.war" -O /var/lib/jetty/webapps/root.war
EXPOSE 8680
