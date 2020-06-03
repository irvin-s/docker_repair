FROM python:2.7.12-slim  
  
RUN pip install \  
pyzmq \  
jinja2 \  
pandas \  
tornado \  
ipython==3.2.0 \  
jsonschema  
  
RUN apt-get -y update \  
&& apt-get -y install curl \  
&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \  
&& apt-get install -y nodejs \  
&& apt-get remove -y curl \  
&& apt-get clean && rm -rf /var/lib/apt/lists/*  
  
RUN npm install -g browserify uglifyjs  
  
COPY ./assets/spot-oa /spot-oa  
RUN cd /spot-oa/ui/ \  
&& npm install reactify d3-queue d3-hierarchy \  
&& npm install \  
&& npm run build-all  
  
RUN python -m IPython.external.mathjax  
  
COPY ./assets/.ipython /root/  
  
WORKDIR /spot-oa/  
  
CMD /spot-oa/runIpython.sh  

