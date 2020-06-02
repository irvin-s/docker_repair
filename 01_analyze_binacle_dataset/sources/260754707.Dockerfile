# Set the base image to use to armhf
FROM resin/rpi-raspbian:jessie

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git unzip python-gevent python-pip python-dev gcc && pip install psutil && DEBIAN_FRONTEND=noninteractive apt-get remove -y gcc python-pip python-dev && DEBIAN_FRONTEND=noninteractive apt-get autoremove && DEBIAN_FRONTEND=noninteractive apt-get clean
RUN cd / && git clone https://github.com/AndreyPavlenko/aceproxy.git
RUN adduser --disabled-password --gecos "" aceproxy
EXPOSE 8000 8081 
VOLUME /aceproxy/ 
ADD aceconfig.py /aceproxy/aceconfig.py

CMD ["/aceproxy/acehttp.py"]
