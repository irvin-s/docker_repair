FROM nginx:stable

COPY nginx.conf /etc/nginx/nginx.conf

# Install prerequisites
RUN apt-get update && apt-get install -y curl && apt-get install -y gnupg
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y bzip2

# Creating working directory.
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

# Copy source code into working directory.
COPY . /usr/src/app/

ENV TWEETS_BASE_URL=http://bop.worldmap.harvard.edu/bopws/tweets/
ENV HEATMAP_FACET_LIMIT=10000
ENV CSV_DOCS_LIMIT=10000

# Install dependencies.
RUN npm install
RUN npm run deploy

ONBUILD COPY . /usr/src/app/

EXPOSE 80
