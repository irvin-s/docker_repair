FROM ubuntu:latest  
  
RUN apt-get update && apt-get install -y \  
software-properties-common \  
python-all-dev \  
curl \  
swig \  
flex \  
bison \  
git \  
gcc \  
g++ \  
make \  
pkg-config \  
glib-2.0 \  
python-gobject-dev \  
valgrind \  
gdb && \  
rm -rf /var/lib/apt/lists/*  
  
RUN useradd r2  
RUN mkdir -p /home/r2/workdir && chown r2:r2 /home/r2/workdir  
  
RUN add-apt-repository ppa:vala-team/ppa  
RUN apt-get update && \  
apt-get -y install valac  
  
WORKDIR /opt  
  
RUN git clone https://github.com/radare/radare2.git radare2 && \  
cd radare2 && \  
./sys/install.sh  
  
RUN mkdir /var/sharedFolder  
RUN mkdir -p /home/r2/.config/radare2  
RUN touch /home/r2/.radare2rc  
  
RUN chown -R r2:r2 /var/sharedFolder  
RUN chown -R r2:r2 /home/r2/  
  
USER r2  
WORKDIR /home/r2/workdir  
CMD ["r2"]  

