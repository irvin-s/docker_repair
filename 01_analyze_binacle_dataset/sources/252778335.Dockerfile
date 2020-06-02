FROM ubuntu  
  
ENV _root /tmk_keyboard/keyboard  
  
RUN apt-get update \  
&& apt-get install -y \  
git make \  
gcc-avr avr-libc \  
gcc-arm-none-eabi \  
gcc-arm-linux-gnueabi \  
libusb-1.0-0-dev \  
&& git clone https://github.com/tmk/tmk_keyboard.git \  
&& apt-get remove -y git \  
&& apt-get -y autoremove \  
&& rm -r /var/lib/apt/lists/*  
  
COPY bin $_root/examples  
  
WORKDIR $_root  
  
ENTRYPOINT [ "./examples/runme.sh" ]  

