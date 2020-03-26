from catholabs/recsysbase  
  
COPY requirements.txt /tmp/  
WORKDIR /tmp  
MAINTAINER CathoLabs catholabs@catho.com  
ENV TERM xterm  
RUN pip install -r requirements.txt --upgrade

