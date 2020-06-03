
FROM ubuntu:14.04

# Update Ubuntu
RUN apt-get update

# Install dependencies needed to run ISE
RUN apt-get -y install libx11-6 libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig1 libxcursor1 
# These two dependencies are needed by Vivado
RUN apt-get -y install libxext6 libxtst6

# Add the Xilinx user
RUN adduser --disabled-password --gecos "" xilinx
RUN mkdir /opt/Xilinx; chown xilinx:xilinx /opt/Xilinx
USER xilinx
