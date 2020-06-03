FROM python:3.5 

RUN apt-get update
RUN apt-get -y install apt-utils autoconf automake curl gcc g++ libtool pkg-config

WORKDIR /merge_machine
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN ldconfig
COPY . /merge_machine

RUN mkdir -p merge_machine/resource/es_linker
# RUN wget "https://data.opendatasoft.com/explore/dataset/geonames-all-cities-with-a-population-1000@public/download/?format=json&timezone=Europe/Berlin" -O merge_machine/resource/es_linker/geonames-all-cities-with-a-population-1000.json
# RUN python3 merge_machine/es_gen_resource.py

RUN apt-get -y install netcat

# CMD wait-for-elasticsearch.sh
# CMD ["python3", "merge_machine/worker.py"]
