FROM ubuntu:16.04

# Install server dependencies
RUN apt-get update --yes && apt-get upgrade --yes \
&& apt-get install --fix-missing git vim \
libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev libpng-dev build-essential g++ \
ffmpeg \
software-properties-common --yes \
redis-server --yes \
python --yes

RUN add-apt-repository ppa:jonathonf/ffmpeg-3 -y
RUN apt-get update --yes && apt-get upgrade --yes
RUN apt-get install ffmpeg -y

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /usr/local/nvm
ENV NODE_6 6.12.0
ENV NODE_7 7.10.1


# Non-privileged user
RUN useradd -m audiogram #reset

# early copy of client side javascript required for postinstall script
ADD ./client/* /home/audiogram/src/client/
ADD ./lib/logger/* /home/audiogram/src/client/

# Install application dependencies (see http://www.clock.co.uk/blog/a-guide-on-how-to-cache-npm-install-with-docker)
ADD ./package.json /home/audiogram/src/package.json
RUN chown -R audiogram:audiogram /home/audiogram

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_6 \
    # && nvm install $NODE_7 \
    && nvm use $NODE_6 \
    && cd /home/audiogram/src \
    # && npm i canvas --save \
    # && nvm use $NODE_7 \
    && npm i

# RUN ln -s `which nodejs` /usr/bin/node
ENV NODE_PATH $NVM_DIR/v$NODE_6/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_6/bin:$PATH

USER audiogram
WORKDIR /home/audiogram/src

# Copy rest of source
USER root
COPY . /home/audiogram/src
RUN chown -R audiogram:audiogram /home/audiogram

RUN npm run build

ENV NODE_ENV production
CMD [ "sh", "bin/start.sh" ]
