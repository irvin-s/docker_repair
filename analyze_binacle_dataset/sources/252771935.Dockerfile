FROM attentive/jace-base  
  
COPY . /jace  
WORKDIR /jace/jace  
RUN pip install -r ../requirements.txt  

