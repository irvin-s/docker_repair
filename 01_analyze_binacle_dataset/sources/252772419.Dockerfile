FROM python:3  
# base ubuntu with python and bash  
LABEL author="avimehenwal"  
ENV python=3  
ENV webframework=cherrypy  
  
COPY . /app  
WORKDIR /app  
RUN pip install -r requirements.txt  
EXPOSE 8081  
# RUN ENVIRONMENT  
#ENTRYPOINT ["python"]  
# if APP-DEPLOY  
CMD ["python", "app.py"]  
  
# if TEST  
#CMD ["py.test", "-s", "test_app.py"]  

