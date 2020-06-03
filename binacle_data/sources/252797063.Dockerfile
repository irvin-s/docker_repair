FROM python:2-onbuild  
RUN mkdir logs && mkdir -p run/undeliverable  
EXPOSE 25  
CMD [ "salmon", "start", "-debug", "True" ]  

