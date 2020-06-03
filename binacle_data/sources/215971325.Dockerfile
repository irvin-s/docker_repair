FROM jamesgroat/golang-nodejs

MAINTAINER mcastro@stratio.com

# Go to working directory
WORKDIR /go/src/app

# Install dependencies
RUN git clone https://github.com/Stratio/real-time-mesos-offers-logging.git .
RUN go get ./...
RUN go build -o app
RUN npm install
RUN node_modules/browserify/bin/cmd.js -t [ babelify --presets [ es2015 react ] ] server/public/js/main.jsx -o server/public/js/bundle.js

CMD ./app --master=zk://10.200.0.152:2181/mesos --port 9095 --hostname 0.0.0.0
