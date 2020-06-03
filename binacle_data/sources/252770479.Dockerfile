FROM ruby:2.3-slim  
MAINTAINER aspgems  
  
RUN apt-get update && \  
apt-get install -qq -y --no-install-recommends \  
build-essential \  
libpq-dev \  
nodejs \  
tzdata \  
libxml2-dev \  
libxslt-dev  
  
ENV APP_HOME=/app  
  
ENV BUNDLE_PATH=$APP_HOME/vendor/bundle  
ENV BUNDLE_BIN $BUNDLE_PATH/bin  
ENV BUNDLE_APP_CONFIG $APP_HOME/.bundle  
ENV PATH $BUNDLE_BIN:$PATH  
WORKDIR /${APP_HOME}  
  
CMD ["echo", "Ruby environment set up"]  

