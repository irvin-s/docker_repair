FROM tiangolo/uwsgi-nginx-flask:python2.7  
# we need pip for packages  
RUN pip install -U pip  
# we also need node for npm for frontend packages  
RUN wget https://deb.nodesource.com/setup_6.x  
RUN chmod +x setup_6.x  
RUN ./setup_6.x  
RUN apt-get install -y nodejs  
RUN npm install -g bower  
  
# copy the service over  
COPY ./app /app  
COPY systems.json /app/  
COPY *.csv /app/  
  
# get python packages  
COPY requirements.txt /tmp/  
RUN pip install -r /tmp/requirements.txt  
  
# get the bower packages  
COPY .bowerrc /  
COPY bower.json /  
WORKDIR /  
RUN bower install --allow-root  
  
WORKDIR /app  

