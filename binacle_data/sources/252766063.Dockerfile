FROM a504082002/ncbi-blast:latest  
  
MAINTAINER a504082002 <a504082002@gmail.com>  
  
RUN apt-get update -qq && \  
apt-get install -yq --no-install-recommends \  
roary \  
python3 \  
python3-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Install celery  
ADD requirements.txt /roaryapp/requirements.txt  
ADD ./roaryapp/ /roaryapp/  
WORKDIR /  
RUN pip3 install -r /roaryapp/requirements.txt  
  
RUN mkdir /input && mkdir /output  
ENTRYPOINT celery worker --app=roaryapp.celeryapp.app -l info  

