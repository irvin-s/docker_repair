FROM registry.access.redhat.com/dotnet/dotnet-20-jenkins-slave-rhel7

EXPOSE 8080
USER 0

ENV PATH=$HOME/.local/bin/:$PATH \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    NVM_DIR=/usr/local/nvm \
    NODE_VERSION=v8.9.1

ENV SUMMARY="Jenkins slave with DOTNET, Mono, Sonar Scanner with MSBuild, NodeJS" \
    DESCRIPTION="This image allows for SonarQube scanning of DotNet applications and running Node applications for other scanning."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Jenkins-Pipeline-SonarScanner-dotnet" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,jenkins-jnlp, jenkins-dotnet, jenkins-sonarrunner" \
      release="1"

RUN pushd /opt \
    && yum install yum-utils \
  	&& rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" \
    && yum-config-manager --add-repo http://download.mono-project.com/repo/centos/ \
    && yum install -y mono-complete \
    && INSTALL_PKGS="tar unzip bc which lsof java-1.8.0-openjdk java-1.8.0-openjdk-devel" \
    && yum install -y $INSTALL_PKGS \
    && rpm -V $INSTALL_PKGS \
    && yum clean all -y \
    && curl -L https://github.com/SonarSource/sonar-scanner-msbuild/releases/download/4.0.2.892/sonar-scanner-msbuild-4.0.2.892.zip -o sonar-scanner-msbuild-4.0.2.892.zip \
    && mkdir /usr/lib/sonar-scanner  \
    && unzip sonar-scanner-msbuild-4.0.2.892.zip -d /usr/lib/sonar-scanner \
    && chmod -R a+rx /usr/lib/sonar-scanner \
    && rm sonar-scanner-msbuild-4.0.2.892.zip \
    && popd

# install Node.js
RUN  rm -R /opt/rh/rh-nodejs6 \
    && mkdir /opt/rh/rh-nodejs6 \
    && touch /opt/rh/rh-nodejs6/enable \
    && chmod a+rx /opt/rh/rh-nodejs6/enable \
    && touch ~/.bash_profile \
    && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm ls-remote \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g snyk \
    && npm install -g snyk-to-html \
    && chmod -R a+rwx /usr/local/nvm \
    && yum clean all -y \
    && mkdir -p /opt/app-root \
    && chmod -R a+rwx /opt/app-root \
    && chown -R 1001:0 /opt/app-root \
    && chmod -R 777 /home/jenkins

ENV OPENSHIFT_JENKINS_JVM_ARCH=x86_64
ENV PATH "$PATH:/usr/lib/sonar-scanner/" 
ENV PATH "$PATH:/usr/local/nvm/versions/node/v8.9.1/bin/" 

USER 1001
