FROM node:7.10-wheezy
RUN npm install web3
RUN npm install bignumber.js
COPY tokenTransferLogs-vs-currentBalance.js tokenTransferLogs-vs-currentBalance.js
CMD node tokenTransferLogs-vs-currentBalance.js
