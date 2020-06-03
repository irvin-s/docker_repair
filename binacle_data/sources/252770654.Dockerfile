FROM aexea/aexea-base:py3.6  
LABEL maintainer "Aexea Carpentry"  
  
EXPOSE 8000  
RUN pip3 install psycopg2 lxml Pillow pandas wheel  
  
ONBUILD COPY requirements*.txt /opt/code/  
ONBUILD COPY pip.conf /root/.config/pip/pip.conf  
ONBUILD WORKDIR /opt/code  
ONBUILD RUN pip3 install -Ur requirements.txt \  
&& if test -e requirements-deploy.txt; then \  
pip3 install -Ur requirements-deploy.txt; \  
fi  
  
ONBUILD ADD . /opt/code  
ONBUILD WORKDIR /opt/code  
ONBUILD USER uid1000  

