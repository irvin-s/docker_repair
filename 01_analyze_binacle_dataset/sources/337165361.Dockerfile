FROM node:8


WORKDIR /app
ADD . /app

RUN npm install -g truffle@4.1.x


ENTRYPOINT ["/bin/bash","/app/docker_run.sh"] 
CMD ["runandtest"]