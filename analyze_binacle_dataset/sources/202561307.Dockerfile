FROM mitchtech/rpi-pifm

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

#RUN apt-get update && apt-get install -y -q \
#    build-essential \
#    ca-certificates \
#    git \
#    python \
#    --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Make-Magazine/PirateRadio.git

CMD ["python", "/PirateRadio/PirateRadio.py"]
