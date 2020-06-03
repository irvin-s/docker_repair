FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get install -y apt-utils
RUN apt-get install -y git
RUN apt-get install -y libpcap-dev
RUN apt-get install -y libglib2.0-dev
RUN apt-get install -y libpython-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wireshark
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wireshark-dev
RUN git clone https://github.com/NationalSecurityAgency/sharkPy 
RUN cd sharkPy && python ./setup.py install

