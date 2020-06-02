FROM python:2.7  
#  
# install dependencies  
#  
WORKDIR /app  
  
COPY files/ .  
  
RUN pip install -r requirements.txt  
  
#CMD ["/env/bin/python", "app.py]  
CMD ["bash"]

