# ΓRF client
FROM ubuntu:xenial

RUN apt update
RUN apt install -y wget git build-essential cmake gpsd gpsd-clients libusb-1.0-0-dev \
 vim librtlsdr-dev python3-dev python3-pip pkg-config libfftw3-dev libhackrf-dev

#
ADD ./3rdparty /3rdparty

# hackrf
RUN cd /tmp; wget -q https://github.com/mossmann/hackrf/releases/download/v2017.02.1/hackrf-2017.02.1.tar.xz
RUN cd /tmp; tar xf hackrf-2017.02.1.tar.xz; cd hackrf-2017.02.1/host; mkdir build
RUN cd /tmp/hackrf-2017.02.1/host/build; cmake ..; make; make install; ldconfig

# rtl-sdr
RUN cd /tmp; git clone https://github.com/keenerd/rtl-sdr
RUN cd /tmp/rtl-sdr; mkdir build; cd build; cmake ..; make; make install

# tpms
RUN cd /tmp; git clone https://github.com/merbanan/rtl_433
RUN cd /tmp/rtl_433; mkdir build; cd build; cmake ..; make; make install

ADD ./requirements.txt /requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r /requirements.txt

ADD ./gammarf.conf /gammarf.conf
ADD ./gammarf.py /gammarf.py
ADD ./modules /modules

RUN chmod +x /gammarf.py
ENV PYTHONIOENCODING UTF-8
CMD /gammarf.py
