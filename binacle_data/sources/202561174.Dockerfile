FROM mitchtech/rpi-wiringpi

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    libasound2-dev \
    memcached \
    mpg123 \
    python-alsaaudio \
    python-pip \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/sammachin/AlexaPi.git && \
    cd AlexaPi && \
    #sed -ni 's/\n/ /g' && \
    pip install -r requirements.txt && \
    touch /var/log/alexa.log

ADD creds.py /AlexaPi/creds.py

#RUN ip = `ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1` && \
#    python ./auth_web.py && \
#    echo "Open http://$ip:5000"

WORKDIR /AlexaPi

CMD ["python", "./auth_web.py"]
