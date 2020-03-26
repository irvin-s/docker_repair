FROM python:3.5  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /dj_app  
WORKDIR /dj_app  
COPY ./dj_app/requirements.txt /dj_app/  
RUN pip install -r requirements.txt  
EXPOSE 8000 9191  
COPY ./dj_app/app-entrypoint.sh /  
ENTRYPOINT ["/app-entrypoint.sh"]  
CMD ["--socket", ":8000"]

