FROM node:0.10

ADD . /app
WORKDIR /app
RUN npm install
RUN apt-get update
RUN apt-get install -y vim
RUN useradd -g root -d /home/term -m -s /bin/bash term
RUN echo 'term:term' | chpasswd
RUN echo 'root:root' | chpasswd

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000"]

