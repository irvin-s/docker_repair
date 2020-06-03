FROM python:2-alpine

#use gunicorn
RUN pip install gunicorn==19.6.0

#use flask
RUN pip install flask
COPY . /usr/src/app/
WORKDIR /usr/src/app/

EXPOSE 5000
ENTRYPOINT ["/usr/local/bin/gunicorn"]

CMD ["-w","1","-b","0.0.0.0:5000","--threads","1","app:app","--access-logfile","/dev/stdout","--error-logfile","/dev/stdout"]