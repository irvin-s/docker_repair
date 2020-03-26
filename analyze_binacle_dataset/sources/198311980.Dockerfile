
# PhantomJS for Selenium
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
  ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/

# Chrome for Selenium
RUN apt-get update && \
  apt-get install unzip && \
  wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  cp chromedriver /usr/local/share/ && \
  ln -s /usr/local/share/chromedriver /usr/local/bin/ && \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y  chromium-browser && \
  rm -rf /var/lib/apt/lists/*

RUN pip install "selenium>=3.141.0,<3.142.0"
