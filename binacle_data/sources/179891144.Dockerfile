FROM ubuntu:14.10

RUN apt-get update
RUN apt-get install -y python3-pip curl
RUN pip3 install bottle
RUN pip3 install httplib2

WORKDIR /home
CMD mkdir config
ADD custservice.py /home/custservice.py
ADD custservice.json /home/config/custservice.json



# expose ports
EXPOSE 8888

# start python script
CMD /home/custservice.py
