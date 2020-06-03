# images/jenkins-plugins/Dockerfile
FROM modernjenkins/jenkins-base
MAINTAINER matt@notevenremotelydorky

LABEL dockerfile_location=https://github.com/technolo-g/modern-jenkins/tree/master/images/jenkins-plugins/Dockerfile \
      image_name=modernjenkins/jenkins-plugins \
      base_image=modernjenkins/jenkins-base

# Add our plugin installation tool. Can be found here and is modified from the
# upstream version.
# https://raw.githubusercontent.com/technolo-g/modern-jenkins/master/images/jenkins-plugins/files/install-plugins.sh
ADD files/install-plugins.sh /usr/local/bin/

# Add our groovy init files
ADD files/init.groovy.d /usr/share/jenkins/ref/init.groovy.d

# Download the Jenkins war
# JENKINS_URL, JENKINS_ROOT, JENKINS_WAR, and JENKINS_SHA are set in the parent
RUN mkdir -p ${JENKINS_ROOT}/ref/warfile \
  && curl -fsSL ${JENKINS_URL} -o ${JENKINS_WAR} \
  && echo "${JENKINS_SHA}  ${JENKINS_WAR}" | sha256sum -c - \
  && chown -R ${user}:${user} ${JENKINS_ROOT}

# We will run all of this as the jenkins user as is dictated by the base imge
USER ${user}

# Install our base set of plugins and their depdendencies that are listed in
# plugins.txt
ADD files/plugins.txt /tmp/plugins-main.txt
RUN install-plugins.sh `cat /tmp/plugins-main.txt`

# Export our war and plugin set as volumes
VOLUME /usr/share/jenkins/ref/plugins
VOLUME /usr/share/jenkins/ref/warfile
VOLUME /usr/share/jenkins/ref/init.groovy.d

# It's easy to get confused when just a volume is being used, so let's just keep
# the container alive for clarity. This entrypoint will keep the container
# running for... infinity!
ENTRYPOINT ["sleep", "infinity"]

