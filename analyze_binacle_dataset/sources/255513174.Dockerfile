FROM cwds/intake_testing_base_image:2.4
LABEL application=intake_accelerator

ENV APP_HOME /ca_intake
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_PATH /ca_intake/ruby_gems

RUN mkdir /build_artefacts
COPY scripts/build.sh /usr/local/bin/build.sh
RUN chmod +x /usr/local/bin/build.sh

COPY . ./
RUN bundle install -j8 --retry=3
RUN CHROME_VERSION=$(google-chrome --version | sed -r 's/[^0-9]+([0-9]+\.[0-9]+\.[0-9]+).*/\1/g') && \
    CHROMEDRIVER_VERSION=$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION) && \
    bundle exec chromedriver-update $CHROMEDRIVER_VERSION
RUN yarn
RUN bin/webpack
