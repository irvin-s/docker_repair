FROM jenkins/jnlp-slave

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

USER root
RUN apt-get update -yqq && apt-get install --no-install-recommends -yqq \
    iproute \
    openssh-client ssh-askpass \
    ca-certificates \
    tar zip unzip \
    wget curl \
    git \
    build-essential \
    less nano tree \
    rlwrap \
    ruby \
    make \
    xmlstarlet \
    crudini \
    mysql-client \
    postgresql-client \
    git

RUN rm -rf /var/lib/apt/lists/* \

# Kubernetes CLI
# See http://kubernetes.io/v1.0/docs/getting-started-guides/aws/kubectl.html
ENV KUBCTL_VERSION=1.12.2
RUN curl https://storage.googleapis.com/kubernetes-release/release/v${KUBCTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# Install Maven
ENV MAVEN_VERSION=3.6.0

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME=/usr/share/maven

# Install Ant
ENV ANT_VERSION=1.10.5

RUN curl -fsSL https://www.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-ant-$ANT_VERSION /usr/share/ant \
  && ln -s /usr/share/ant/bin/ant /usr/bin/ant

ENV ANT_HOME=/usr/share/ant

# Install Gradle
ENV GRADLE_VERSION 4.10.2

RUN wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    && unzip gradle.zip -d /usr/share/ \
    && rm gradle.zip \
    && mv /usr/share/gradle-${GRADLE_VERSION} /usr/share/gradle \
    && ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle

# Install Docker
ENV DOCKER_VERSION=18.06.1-ce
ENV DOCKER_COMPOSE_VERSION=1.23.1

RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz | tar --strip-components=1 -xz -C /usr/local/bin docker/docker \
    && curl -fsSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && groupadd docker \
    && usermod -aG docker jenkins

# Install JMETER
ENV JMETER_VERSION=5.0

RUN mkdir /opt/jmeter \
      && wget --no-verbose -O - "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz" \
| tar -xz --strip=1 -C /opt/jmeter

USER jenkins




