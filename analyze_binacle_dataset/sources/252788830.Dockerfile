FROM ruby:2.3  
ENV GHERKIN_VERSION 2.12.2  
ENV NOKOGIRI_VERSION 1.6.1  
# RUN gem install gherkin --version "$GHERKIN_VERSION"  
RUN gem install nokogiri --version "$NOKOGIRI_VERSION"  
  
ENV GEM_HOME /usr/local/bundle  
ENV BUNDLE_PATH="$GEM_HOME" \  
BUNDLE_BIN="$GEM_HOME/bin" \  
BUNDLE_SILENCE_ROOT_WARNING=1 \  
BUNDLE_APP_CONFIG="$GEM_HOME"  
ENV PATH $BUNDLE_BIN:$PATH  
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \  
&& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"  
  
CMD [ "irb" ]  

