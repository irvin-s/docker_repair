FROM texastribune/gunicorn  
  
RUN apt-get -yq update && apt-get -yq install python3-pip  
  
# Remove python2 version of gunicorn  
RUN /usr/bin/yes | pip uninstall -q gunicorn  
  
RUN pip3 install gunicorn==19.1.1  

