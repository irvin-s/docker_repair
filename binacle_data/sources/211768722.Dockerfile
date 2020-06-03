FROM node:5
RUN mkdir /code
WORKDIR /code
ADD . /code/
#RUN npm install
