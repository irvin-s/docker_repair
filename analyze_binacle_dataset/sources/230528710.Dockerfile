FROM node:0.12

RUN mkdir /opt/lambda-rds-loader
ADD . /opt/lambda-rds-loader
RUN ln -s /opt/lambda-rds-loader/run.js /usr/local/bin/lambda-rds-loader && chmod 755 /usr/local/bin/lambda-rds-loader

CMD []