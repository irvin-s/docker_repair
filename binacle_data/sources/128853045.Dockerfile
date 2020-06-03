FROM java:8

# Set Grails version
ENV SCOPE docker
ENV GRAILS_VERSION 2.4.5

# Install Grails
WORKDIR /usr/lib/jvm
RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
unzip grails-$GRAILS_VERSION.zip && \
rm -rf grails-$GRAILS_VERSION.zip && \
ln -s grails-$GRAILS_VERSION grails

# Setup Grails path.
ENV GRAILS_HOME /usr/lib/jvm/grails
ENV PATH $GRAILS_HOME/bin:$PATH

# Create App Directory
RUN mkdir /app
COPY . /app

# Set Workdir /app and download dependecies
WORKDIR /app
RUN grails refresh-dependencies

# Set Default Behavior
ENTRYPOINT ["grails"]
CMD ["run-app"]