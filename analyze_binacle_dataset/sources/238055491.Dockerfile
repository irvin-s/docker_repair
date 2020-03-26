FROM openjdk:8

ENV GRADLE_VERSION=3.3 \
    GRADLE_HOME=/opt/gradle \
    GRADLE_FOLDER=/root/.gradle

ENV KOTLIN_VERSION=1.0.5 \
    KOTLIN_HOME=/usr/share/kotlin

# Download and extract gradle to opt folder
RUN apt-get update ; apt-get install -y openjfx curl jq \
    && cd /tmp ; wget --no-check-certificate --no-cookies https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt \
    && ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle \
    && rm -f gradle-${GRADLE_VERSION}-bin.zip \
    && update-alternatives --install "/usr/bin/gradle" "gradle" "/opt/gradle/bin/gradle" 1 \
    && update-alternatives --set "gradle" "/opt/gradle/bin/gradle" \
    && mkdir -p $GRADLE_FOLDER \
    && cd /tmp ; wget --no-check-certificate --no-cookies "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" \
    && unzip "kotlin-compiler-${KOTLIN_VERSION}.zip" \
    && mkdir "${KOTLIN_HOME}" \
    && rm "/tmp/kotlinc/bin/"*.bat \
    && mv "/tmp/kotlinc/bin" "/tmp/kotlinc/lib" "${KOTLIN_HOME}" \
    && ln -s "${KOTLIN_HOME}/bin/"* "/usr/bin/" \
    && rm -rf /tmp/*
