FROM ashdev/docker-training-toolbox
MAINTAINER AshDev <ashdevfr@gmail.com>

ENV workdir_path /home/workspace
WORKDIR ${workdir_path}/

RUN git config --global url."https://".insteadOf git://

ADD .eslintrc ${workdir_path}
ADD .bowerrc ${workdir_path}
ADD package.json ${workdir_path}
ADD bower.json ${workdir_path}

RUN npm install

RUN bower install --config.interactive=false --allow-root

EXPOSE 3000 3010

VOLUME ${workdir_path}

CMD ["gulp"]
