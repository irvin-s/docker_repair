# Use an official Python runtime as a parent image
FROM ubuntu


MAINTAINER ESP32-Toolchain

#USER root


# Update aptitude with new repo
RUN apt-get update

# Install software
RUN apt-get install -y git
RUN apt-get install git wget make libncurses-dev flex bison gperf python python-serial -y

#RUN useradd -d /esp32/ -m -s /bin/bash esp32

RUN mkdir -p /home/esp

# Set the working directory to ~/esp/esp-idf
WORKDIR /home/esp

RUN wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
RUN tar -xzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz


#clone GIT
RUN git clone --recursive https://github.com/espressif/esp-idf.git

#go to example directory
#WORKDIR home/esp/hello_world
#RUN make -j5
# Copy the current directory contents into the container at /app
#ADD . /home/app

WORKDIR /home/app


ENV PATH $PATH:"/home/esp/xtensa-esp32-elf/bin"
ENV IDF_PATH "/home/esp/esp-idf"

RUN echo $PATH
RUN echo $IDF_PATH


CMD /bin/bash


