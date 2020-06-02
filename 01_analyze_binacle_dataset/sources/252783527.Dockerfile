FROM python:3.6  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /dj_app  
WORKDIR /dj_app  
COPY ./dj_app/requirements.txt /dj_app/  
COPY ./app-entrypoint.sh /  
RUN pip install django_debug_toolbar django_extensions  
RUN pip install -r requirements.txt  
EXPOSE 8000 9191  
ENTRYPOINT ["/app-entrypoint.sh"]  
#CMD ["--socket", ":8000"]  

