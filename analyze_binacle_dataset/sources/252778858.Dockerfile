FROM python:3.5  
ADD . /project  
WORKDIR /project  
RUN pip install -r requirements.txt  
RUN useradd -s /bin/bash user  
USER user  
EXPOSE 8000  
CMD python app.py  

