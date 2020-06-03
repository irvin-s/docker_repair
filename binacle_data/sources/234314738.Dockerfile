FROM digitallyseamless/nodejs-bower-grunt:5
MAINTAINER d33d33 <kevin@d33d33.fr>

EXPOSE 8080

# Setup work directory
RUN mkdir -p /home/d33d33/metronome-ui
WORKDIR /home/d33d33/metronome-ui

# Install dependencies
RUN npm install -g http-server
COPY package.json ./package.json
RUN npm install

# Build metronome ui
COPY . ./
RUN grunt build

CMD ["http-server",  "-p", "8080", "./build"]
