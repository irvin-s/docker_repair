FROM ubuntu

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install curl wget git vim python python-pip python-dev

# Install anthracite
RUN git clone --recursive https://github.com/Dieterbe/anthracite.git /opt/anthracite

add	./config.py /opt/anthracite/config.py

EXPOSE 8081

CMD ["python", "/opt/anthracite/anthracite-web.py"]

