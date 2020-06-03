FROM ubuntu:14.04

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y lib32z1 libc6-i386 xinetd 
RUN apt-get install -y libstdc++6 lib32stdc++6
RUN apt-get install -y gcc
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

RUN pip3 install pillow
RUN pip3 install numpy
RUN pip3 install --upgrade pip
RUN pip3 install tensorflow 

RUN useradd -m ctf

COPY ./bin/ /home/ctf/
COPY ./ctf.xinetd /etc/xinetd.d/ctf
COPY ./start.sh /start.sh

RUN chmod +x /start.sh
RUN chown -R root:ctf /home/ctf
RUN chmod -R 750 /home/ctf
RUN chmod -R 740 /home/ctf/flag
WORKDIR /

CMD ["/start.sh"]

EXPOSE 9999
