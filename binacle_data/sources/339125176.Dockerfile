FROM base_image:0.1.0

RUN apt-get -q update

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt