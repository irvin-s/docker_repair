FROM python:3.6.1-slim  
  
RUN groupadd user && useradd --create-home --home-dir /home/user -g user user  
WORKDIR /home/user  
  
USER user  
  
ENTRYPOINT [""]  

