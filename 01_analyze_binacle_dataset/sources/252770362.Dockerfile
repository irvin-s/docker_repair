FROM awilson/connector:develop  
MAINTAINER toolbox@cloudpassage.com  
  
RUN apt-get update && apt-get -y upgrade && apt-get install -y python-pip  
  
COPY assets/runner.sh /  
COPY app /app  
  
# Install the Halo SDK  
COPY packages /app/packages  
RUN cd /app && \  
pip install ./packages/sdk  
  
CMD /runner.sh  

