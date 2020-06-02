FROM python:3.6-slim-stretch  
  
RUN apt-get update  
RUN apt-get install -y git  
  
RUN git clone https://github.com/droope/droopescan.git  
  
WORKDIR ./droopescan  
  
RUN pip install -r requirements.txt  
  
ADD ./scripts/droopescan-wrapper .  
RUN chmod +x ./droopescan-wrapper  
  
ENTRYPOINT ["./droopescan-wrapper"]  

