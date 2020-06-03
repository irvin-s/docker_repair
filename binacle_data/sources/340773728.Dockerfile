FROM python:2.7
RUN apt-get install curl -y
RUN curl -L https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine
RUN chmod +x /usr/local/bin/docker-machine
ADD /requirements/base.txt requirements.txt

# Get pip to download and install requirements:
RUN pip install -r requirements.txt
ADD /app /app

# run cherrypy on all interfaces
ENV MACHINERY_RUN_GLOBAL True

CMD python /app/server.py