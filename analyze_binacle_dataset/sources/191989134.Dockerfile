From node

WORKDIR /app

RUN npm install mosca -g

CMD ["mosca","-v"]
