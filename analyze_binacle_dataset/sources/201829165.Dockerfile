FROM java:openjdk-8-jdk

# Add package sources and install
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    echo "deb http://repos.mesosphere.io/debian jessie main" | tee /etc/apt/sources.list.d/mesosphere.list && \
    echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y --force-yes mesos=0.27.2-2.0.15.debian81 \
    wget \
    python \
    make \
    gcc \
    build-essential \
    g++

# Overall ENV vars
ENV APP_BASE_PATH /app
ENV SPARK_VERSION 1.6.0
ENV NODE_VERSION v5.8.0

# Create folders for app
RUN mkdir -p $APP_BASE_PATH && \
    mkdir -p $APP_BASE_PATH/fileCache && \
    mkdir -p $APP_BASE_PATH/tmpCache && \
    mkdir -p $APP_BASE_PATH/config && \
    mkdir -p $APP_BASE_PATH/docs && \
    mkdir -p $APP_BASE_PATH/lib && \
    mkdir -p $APP_BASE_PATH/logs && \
    mkdir -p $APP_BASE_PATH/routes && \
    mkdir -p $APP_BASE_PATH/build && \
    mkdir -p $APP_BASE_PATH/spark

# Install Node.js 5.x
RUN wget --no-check-certificate https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf node-$NODE_VERSION-linux-x64.tar.gz && \
    rm node-$NODE_VERSION-linux-x64.tar.gz

# Spark ENV vars
ENV SPARK_VERSION_STRING spark-$SPARK_VERSION-bin-hadoop2.6
ENV SPARK_DISTRIBUTION_FILE_NAME $SPARK_VERSION_STRING.tgz
ENV SPARK_DOWNLOAD_URL http://d3kbcqa49mib13.cloudfront.net/$SPARK_DISTRIBUTION_FILE_NAME
ENV SPARK_PACKAGE_PATH $APP_BASE_PATH/spark/$SPARK_DISTRIBUTION_FILE_NAME

# Download and unzip Spark
RUN wget $SPARK_DOWNLOAD_URL && \
    mkdir -p /usr/local/spark && \
    tar xvf $SPARK_VERSION_STRING.tgz -C /tmp && \
    cp -rf /tmp/$SPARK_VERSION_STRING/* /usr/local/spark/ && \
    rm -rf -- /tmp/$SPARK_VERSION_STRING && \
    mv $SPARK_DISTRIBUTION_FILE_NAME $SPARK_PACKAGE_PATH

# Set SPARK_HOME
ENV SPARK_HOME /usr/local/spark

# Set ASSEMBLY_JAR
ENV ASSEMBLY_JAR $SPARK_HOME/lib/spark-assembly-$SPARK_VERSION-hadoop2.6.0.jar

# Set native Mesos library path
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so

# Add Spark-Server files
ADD spark-server.js $APP_BASE_PATH/spark-server.js
ADD package.json $APP_BASE_PATH/package.json
ADD ./config $APP_BASE_PATH/config
ADD ./docs $APP_BASE_PATH/docs
ADD ./lib $APP_BASE_PATH/lib
ADD ./routes $APP_BASE_PATH/routes
ADD ./build $APP_BASE_PATH/build

# Set working directory
WORKDIR $APP_BASE_PATH

# Install node-gyp
RUN npm install -g node-gyp

# Setup of the Spark-Server
RUN chmod +x spark-server.js && \
    npm install

CMD ["node", "/app/spark-server.js"]