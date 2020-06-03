FROM redis:alpine

# Want to copy over the contents of this repo to the code
#	section so that we have the source
ADD ./launch_nucleus.sh /nucleus/launch.sh
ADD ./redis.conf /nucleus/redis.conf
ADD . /atom

# Install required linux packages
RUN apk add --no-cache gcc musl-dev g++
RUN apk add --no-cache make cmake git

# Install essentials for python
RUN apk add --no-cache python3
RUN python3 -m ensurepip
RUN pip3 install --upgrade pip setuptools

# Build and install msgpack
RUN pip3 install msgpack
WORKDIR /usr/src
RUN git clone https://github.com/msgpack/msgpack-c.git
WORKDIR /usr/src/msgpack-c
RUN cmake -DMSGPACK_CXX11=ON . && make install

# Build and install python library for atom
WORKDIR /atom/languages/python
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

# Install depedencies for atom-cli
WORKDIR /atom/utilities/atom-cli
RUN pip3 install -r requirements.txt
RUN cp atom-cli.py /usr/bin/atom-cli
RUN chmod +x /usr/bin/atom-cli

# Change directory to nucleus and chown the launch script
WORKDIR /nucleus
RUN chmod +x launch.sh
CMD ["./launch.sh"]
