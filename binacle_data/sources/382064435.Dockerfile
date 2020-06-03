FROM extellisys/debian-sid
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install --assume-yes gcc-4.8 build-essential make libc6-dev-i386 libc6-i686 git-core python python-setuptools python-pip
WORKDIR /root
RUN git clone https://github.com/JonathanSalwan/ROPgadget.git
RUN cd ROPgadget/dependencies/capstone-next && ./make.sh && ./make.sh install && cd ./bindings/python && make install
#RUN cd ROPgadget && python setup.py install
RUN pip install ropgadget
ADD ./ /root/
