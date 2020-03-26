FROM gliderlabs/alpine:3.2  
# install frequently used packages  
RUN apk-install git bash  
  
# install node  
RUN apk-install nodejs  
  
# install python (gliderlabs/python-runtime)  
RUN apk-install python3 python3-dev build-base \  
&& pip3 install virtualenv \  
&& echo "Dockerfile" >> /etc/buildfiles \  
&& echo ".onbuild" >> /etc/buildfiles \  
&& echo "requirements.txt" >> /etc/buildfiles  
  
RUN npm install -g webpack  
  
WORKDIR /app  
COPY package.json /app/  
RUN npm install && rm /app/package.json  
  
# ONBUILD actions  
ONBUILD COPY . /app  
ONBUILD RUN /app/.onbuild || true  
ONBUILD RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt  
ONBUILD RUN npm install  
  
EXPOSE 8080  
CMD ["/env/bin/python", "main.py"]  

