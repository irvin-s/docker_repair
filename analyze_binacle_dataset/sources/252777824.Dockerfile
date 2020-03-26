FROM alpine  
MAINTAINER Iman Tabrizian <tabrizian@outlook.com>  
MAINTAINER Parham Alvani <parham.alvani@gmail.com>  
  
EXPOSE 8080  
# Install packages  
RUN apk --update add python3  
RUN apk --update add --virtual build-dependencies gcc musl-dev python3-dev  
  
# Let's Go Home  
WORKDIR /home/root  
  
# I1820  
WORKDIR /home/root/I1820  
COPY . .  
RUN pyvenv .  
RUn pip3 install --upgrade pip  
RUN pip3 install -r requirements.txt  
  
# Remove packages  
RUN apk del build-dependencies  
  
# Cleanup  
RUN rm -rf /var/cache/apk/*  
  
# I1820 Configurations  
# TODO: Database configuration  
# TODO: MQTT Broker  
# Entrypoint Script  
ENTRYPOINT ["/home/root/I1820/18.20-serve.py"]  

