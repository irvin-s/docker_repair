FROM ubuntu
RUN apt-get update && apt-get -y upgrade && apt-get -y install python-twisted
EXPOSE 8000
ADD echoserv.py /server.py
CMD /server.py
