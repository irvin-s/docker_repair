FROM cwds/intake_testing_base_image:2.3
ENV APP_HOME /ca_intake
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ENV DISPLAY :1
ENV BUNDLE_PATH /ruby_gems
