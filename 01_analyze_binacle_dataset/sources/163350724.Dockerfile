FROM clojure:lein-2.7.1

RUN /bin/bash -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'

RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update

RUN apt-get install -y google-chrome-stable

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

RUN apt-get install -y nodejs
