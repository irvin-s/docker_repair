FROM centos:7  
EXPOSE 8080  
RUN mkdir -p /usr/src/demo-app  
COPY requirements.txt /usr/src/demo-app  
WORKDIR /usr/src/demo-app/  
  
RUN yum -y install centos-release-scl && \  
yum -y install --setopt=tsflags=nodocs rh-python35-python-pip && \  
source scl_source enable rh-python35 && \  
pip install --no-cache-dir -U pip setuptools && \  
pip install --no-cache-dir -r requirements.txt && \  
python -m pip uninstall -y pip setuptools && \  
yum clean all  
  
# entrypoint to enable scl python at runtime  
RUN echo $'#!/bin/sh\n\  
source scl_source enable rh-python35\n\  
exec "$@"' > /usr/bin/entrypoint.sh && \  
chmod +x /usr/bin/entrypoint.sh  
  
COPY src /usr/src/demo-app/src  
WORKDIR /usr/src/demo-app/src  
  
USER 99  
ENTRYPOINT [ "entrypoint.sh" ]  
CMD python app.py  

