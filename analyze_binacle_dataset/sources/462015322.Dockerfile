FROM ubuntu:18.04
MAINTAINER Benjamin Henrion <zoobab@gmail.com>
LABEL Description="This image builds a JTAG Versaloon firmware for the STM32 Bluepill board." 

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q make gcc-arm-none-eabi binutils sudo stm32flash

ENV user versaloon
RUN useradd -d /home/$user -m -s /bin/bash $user
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
RUN chmod 0440 /etc/sudoers.d/$user

USER $user
WORKDIR /home/$user
RUN mkdir -pv code
COPY . ./code/
RUN sudo chown $user.$user -R /home/$user/code
WORKDIR /home/$user/code/
RUN make
