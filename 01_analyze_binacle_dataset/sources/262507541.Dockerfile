#FROM ubuntu:latest
FROM python:latest
EXPOSE 8000
#RUN apt-get update -y
#RUN apt-get install -y python3-pip python3-dev build-essential
#RUN a2enmod proxy && a2enmod proxy_ajp && a2enmod proxy_http && a2enmod rewrite && a2enmod deflate && a2enmod headers //
#&& a2enmod proxy_balancer && a2enmod proxy_connect && a2enmod proxy_html
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
run pip3 install gunicorn
#ENTRYPOINT ["python3"]
#CMD ["main.py"]
CMD ["/usr/local/bin/gunicorn", "-w", "2", "-b", ":8000", "--log-file", "/var/nijis_logs/nijis.log", "--capture-output", "main:app"]