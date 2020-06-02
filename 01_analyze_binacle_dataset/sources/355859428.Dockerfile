FROM cfplatformeng/tile-generator

ADD https://cli.run.pivotal.io/stable?release=linux64-binary&source=github-rel cf_cli.tgz
RUN tar xvf cf_cli.tgz cf
RUN mv cf /bin
RUN cf --version
