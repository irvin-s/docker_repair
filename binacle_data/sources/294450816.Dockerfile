FROM tiangolo/uwsgi-nginx:python3.6

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

EXPOSE 5000
# CMD wait-for-elasticsearch.sh
# CMD ["uwsgi",  "--http", "0.0.0.0:5000", "-b", "32768", "--wsgi-file", "merge_machine/api.py", "--callable", "app", "--processes", "4", "--threads","2"]

