FROM netcool/omnibus
MAINTAINER Julius Loman <lomo@kyberia.net>

# Add installation media
COPY p-tivoli-eif-response.xml /tmp/install/

# Perform installation
RUN cd /tmp/install && \
    curl -O $INSTALLHOST/im-nco-p-tivoli-eif-13_0.zip && unzip -q -d /tmp/install/probe im-nco-p-tivoli-eif-13_0.zip && \
    /home/netcool/IBM/InstallationManager/eclipse/IBMIM -acceptLicense -ShowVerboseProgress -silent -nosplash -input /tmp/install/scripts/omnibus-response.xml && \
    chmod +x /run_objectserver.sh && \ 
# Optially remove Installation Manager stuff to lower image footprint
#   rm -rf /home/netcool/var /home/netcool/IBM && \
    rm -rf /tmp/install

VOLUME /db

CMD /run_objectserver.sh
