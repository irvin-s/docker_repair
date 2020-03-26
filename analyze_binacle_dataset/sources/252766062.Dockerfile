FROM java:8  
MAINTAINER a504082002 <a504082002@gmail.com>  
  
# Install dependencies  
RUN apt-get update -qq && \  
apt-get install -yq --no-install-recommends git \  
less \  
libdatetime-perl \  
libxml-simple-perl \  
libdigest-md5-perl \  
bioperl \  
python3 \  
python3-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# clone prokka  
RUN git clone https://github.com/tseemann/prokka.git && \  
prokka/bin/prokka --setupdb  
ENV PATH $PATH:/prokka/bin  
  
# Install celery  
ADD requirements.txt /prokkaapp/requirements.txt  
ADD ./prokkaapp/ /prokkaapp/  
WORKDIR /  
RUN pip3 install -r prokkaapp/requirements.txt  
  
RUN mkdir /input && mkdir /output  
ENTRYPOINT celery worker --app=prokkaapp.celeryapp.app -l info  
  

