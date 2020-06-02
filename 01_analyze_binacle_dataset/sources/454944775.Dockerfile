# Copyright 2017 - Dechain User Group
# Ethereum Smart-Contracts polygon

FROM ethereum/solc:0.4.18
LABEL name=eth-polygon

RUN apk add --update bash vim emacs-nox less tree sudo tmux curl tig \
        nodejs yarn git openssl \
        make perl libc-dev gcc jansson-dev
RUN adduser -D node && echo "node:node" | chpasswd && adduser node wheel \
	 && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER node
RUN mkdir /home/node/npm-global /home/node/tools \
    && yarn config set prefix /home/node/npm-global \
    && ln -s /projects /home/node/projects
# not using npm:    && npm config set prefix /home/node/npm-global \

ENV PATH="/home/node/npm-global/bin:/home/node/node_modules/.bin:${PATH}"
WORKDIR /home/node

RUN echo "installing jshon" \
	&& cd ~/tools \
	&& git clone https://github.com/mbrock/jshon.git && cd jshon \
	&& make && sudo make install \
	&& echo "installing dapphub/seth" \
	&& cd ~/tools \
	&& git clone https://github.com/dapphub/seth.git \
	&& cd seth && git checkout 0ad3330

COPY ./.inputrc ./.bashrc ./package.json /home/node/
RUN cd ~/tools && yarn install

EXPOSE 8545
ENTRYPOINT ["/bin/bash"]
