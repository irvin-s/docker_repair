FROM eeacms/zope:2.13.23  
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>  
  
COPY src/versions.cfg $ZOPE_HOME/  
COPY src/sources.cfg $ZOPE_HOME/  
COPY src/plone.cfg $ZOPE_HOME/  
COPY src/base.cfg $ZOPE_HOME/  
  
USER root  
RUN ./install.sh  
USER zope-www  

