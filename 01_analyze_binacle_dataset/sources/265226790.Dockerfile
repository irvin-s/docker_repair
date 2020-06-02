FROM node:latest

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl gcc \
    && apt-get -y autoclean

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy --no-install-recommends install

RUN echo "int chown() { return 0; }" > preload.c && gcc -shared -o /libpreload.so preload.c && rm preload.c
ENV LD_PRELOAD=/libpreload.so

# confirm versions
RUN node -v
RUN npm -v

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY ./.babelrc /usr/src/app/
COPY ./src /usr/src/app/src

RUN npm run build
RUN chmod +x ./dist/svg_to_png.js
EXPOSE 3000

ENTRYPOINT ["node", "./dist/svg_to_png.js", "--port", "3000"]
