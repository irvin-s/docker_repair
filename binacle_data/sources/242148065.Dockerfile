FROM python:2

RUN apt-get update
RUN yes | apt-get install ucspi-tcp

WORKDIR /usr/src/app
RUN pip install --no-cache-dir matplotlib scipy numpy

EXPOSE 7777

RUN echo "YAAY"
COPY ./hierarchical_clustering.py .
RUN chmod +x ./hierarchical_clustering.py

CMD [ "tcpserver", "-v", "-P", "-R", "-H", "0.0.0.0", "7777", "./hierarchical_clustering.py" ]
