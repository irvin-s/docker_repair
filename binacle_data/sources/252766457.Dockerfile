FROM abstracttechnology/plone:5.0  
MAINTAINER Giorgio <giorgio.borelli@abstract.it>  
  
COPY buildout.cfg buildout.cfg  
RUN bin/buildout -v  

