FROM node:10-alpine
MAINTAINER Ryan Petschek <petschekr@gmail.com>

# Deis wants bash
RUN apk update && apk add bash
RUN apk add git

# Bundle app source
WORKDIR /usr/src/registration
COPY . /usr/src/registration
RUN npm install
RUN npm run build

# Set Timezone to EST
RUN apk add tzdata
ENV TZ="/usr/share/zoneinfo/America/New_York"

# Deis wants EXPOSE and CMD
EXPOSE 3000
CMD ["npm", "start"]
