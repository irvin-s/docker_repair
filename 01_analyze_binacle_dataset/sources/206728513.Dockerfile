# Building:
# docker build -t cows .

# Running:
# docker run cows <cow_number>

FROM node:8.9.4-alpine

RUN mkdir -p /code/
WORKDIR /code/

RUN npm init -y && npm install cows
ADD show_cow.js ./

ENTRYPOINT ["node", "show_cow.js"]
