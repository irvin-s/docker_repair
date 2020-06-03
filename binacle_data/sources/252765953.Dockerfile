FROM python:3-alpine  
ENV VERSION=3.0.4  
RUN pip install flake8==$VERSION  
ENTRYPOINT ["flake8"]  
CMD ["/code"]  
WORKDIR /  
VOLUME ["/setup.cfg", "/code"]  

