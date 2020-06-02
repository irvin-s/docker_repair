FROM clojure
WORKDIR /app
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g less less-plugin-clean-css
COPY project.clj /app

RUN lein deps