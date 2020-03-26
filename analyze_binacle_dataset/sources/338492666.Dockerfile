FROM node:10.5.0

# RUN git clone https://github.com/BobWallet/BobWallet.git /bobwallet
COPY . /bobwallet

WORKDIR /bobwallet

RUN npm install
RUN npm run babel
RUN npm run build

EXPOSE 8081
EXPOSE 443
EXPOSE 80

CMD ["npm", "run", "server"]
