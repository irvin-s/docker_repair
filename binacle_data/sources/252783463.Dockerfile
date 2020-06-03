# Docker file for the workshop_2018 plugin app  
FROM fnndsc/ubuntu-python3:latest  
MAINTAINER fnndsc "dev@babymri.org"  
ENV APPROOT="/usr/src/workshop_2018" VERSION="0.1"  
COPY ["workshop_2018", "${APPROOT}"]  
COPY ["requirements.txt", "${APPROOT}"]  
  
WORKDIR $APPROOT  
  
RUN pip install -r requirements.txt  
  
CMD ["workshop_2018.py", "--json"]

