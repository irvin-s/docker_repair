FROM node:8
# ADD . /code
COPY package.json package-lock.json /code/
WORKDIR /code
RUN npm install
CMD npm run dev
