FROM ros

RUN apt-get update \
    && apt-get install -y git wget sudo libjpeg-dev libcairo-dev npm ros-kinetic-rosbridge-suite
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN useradd -m -g users ros
RUN echo "ros ALL=(ALL) NOPASSWD: /usr/bin/apt-get" >> /etc/sudoers
RUN npm install -g web3@0.20.1

USER ros
RUN rosdep update

RUN cd ~ && git clone --recursive https://github.com/airalab/aira-IoT \
    && rm -rf aira-IoT/src/dron_ros_tutorial \
    && cd aira-IoT/src \
    && . /opt/ros/kinetic/setup.sh && catkin_init_workspace

RUN cd ~/aira-IoT && . /opt/ros/kinetic/setup.sh \
    && rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y \
    && catkin_make

RUN cd ~/aira-IoT/src/aira_ros_bridge/aira_ros_bridge && npm install

RUN cd ~ && wget --no-check-certificate -O - -q https://dist.ipfs.io/go-ipfs/v0.4.8/go-ipfs_v0.4.8_linux-amd64.tar.gz | tar xzv go-ipfs/ipfs && mv go-ipfs bin

RUN sed -i "0,/localhost/{s/localhost/parity/}" ~/aira-IoT/src/aira_ros_bridge/aira_ros_bridge/lib/aira_bridge.js

VOLUME ["/home/ros/state"]
WORKDIR /home/ros

ADD ./listen-market.js /usr/local/bin/listen-market.js
ADD ./run-liability.sh /usr/local/bin/run-liability.sh
ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
