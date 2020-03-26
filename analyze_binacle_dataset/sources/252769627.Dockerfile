FROM gliderlabs/alpine:3.3  
RUN apk-install \  
python3 \  
python3-dev \  
build-base \  
&& python3 -m ensurepip \  
&& pip3 install virtualenv \  
&& echo "Dockerfile" >> /etc/buildfiles \  
&& echo ".onbuild" >> /etc/buildfiles \  
&& echo "requirements.txt" >> /etc/buildfiles  
  
WORKDIR /app  
  
ONBUILD COPY . /app  
ONBUILD RUN /app/.onbuild || true  
ONBUILD RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt  
  
EXPOSE 8080  
CMD ["/env/bin/python", "main.py"]  

