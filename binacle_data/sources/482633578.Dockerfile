# BUILD INSTRUCTIONS
# sudo docker build -t etherwallet .
# sudo docker run -i --rm -p 3000:3000 etherwallet

FROM stakater/base

ADD . ./ether-wallet/

WORKDIR ./ether-wallet

RUN curl https://install.meteor.com/ | sh

RUN meteor npm install

ENTRYPOINT ["meteor", "--allow-superuser"]
