FROM openjdk:8-jdk-alpine

ENV JENKINS_OPTS JENKINS_USER=root

USER root

# Install Python3.6 

RUN apk add --no-cache python3 libffi-dev openssl-dev&& \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip install --upgrade pip && \
    pip install python-jenkins==1.1.0 jinja2==2.10 hvac==0.6.2 argparse==1.4.0 requests==2.19.1 pyyaml==3.13 kubernetes==6.0.0 && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache


# Install Jenkins 

RUN apk add --no-cache gcc musl-dev git openssh-client curl unzip bash ttf-dejavu coreutils tini 

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000

ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN addgroup -g ${gid} ${group} \
    && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

# jenkins version being bundled in this docker image
ARG JENKINS_VERSION
ENV JENKINS_VERSION ${JENKINS_VERSION:-2.107.3}

# jenkins.war checksum, download will be validated using it
ARG JENKINS_SHA=902d670e3a57670202e01402ca5ea1142c08d187636dd979d33ef317dbe7c6eb

# Can be used to customize where jenkins.war get downloaded from
ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

# could use ADD but this one does not check Last-Modified header neither does it allow to control checksum
# see https://github.com/docker/docker/issues/8331
#RUN curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
#  && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" | sha256sum -c -

RUN curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
    && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" 

ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
RUN chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref && mkdir $JENKINS_HOME/users

# for main web interface:
EXPOSE ${http_port}

# will be used by attached slave agents:
EXPOSE ${agent_port}

ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

COPY jenkins-support /usr/local/bin/jenkins-support
COPY jenkins.sh /usr/local/bin/jenkins.sh
COPY tini-shim.sh /bin/tini

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

# from a derived Dockerfile, can use `RUN plugins.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh
COPY install-plugins.sh /usr/local/bin/install-plugins.sh

# Workaround to install active parameter plugin
COPY ./plugins/scriptler-2.9.hpi /usr/share/jenkins
COPY ./plugins/uno-choice-1.5.3.hpi /usr/share/jenkins

# Deploy Customzied jenkins config.xml and add admin user 
COPY ./config.xml $JENKINS_HOME/
COPY ./users/  $JENKINS_HOME/users/

# Add WCS Continous Deploy Job 

# Create the job workspaces
RUN mkdir -p "$JENKINS_HOME"/workspace/DeployWCSCloud_Base

# Create the jobs folder recursively
RUN mkdir -p "$JENKINS_HOME"/jobs/DeployWCSCloud_Base

# Add the custom configs to the container
COPY ./setup/jobs/DeployWCSCloud_Base.xml "$JENKINS_HOME"/jobs/DeployWCSCloud_Base/config.xml
COPY ./setup/jobs/BuildDockerImage_Base.xml "$JENKINS_HOME"/jobs/BuildDockerImage_Base/config.xml
COPY ./setup/jobs/ManageConfigMap_Base.xml "$JENKINS_HOME"/jobs/ManageConfigMap_Base/config.xml
COPY ./setup/jobs/ManageDockerfile_Base.xml "$JENKINS_HOME"/jobs/ManageDockerfile_Base/config.xml
COPY ./setup/jobs/ManageVaultConfig_Base.xml "$JENKINS_HOME"/jobs/ManageVaultConfig_Base/config.xml
COPY ./setup/jobs/AddCert_Base.xml "$JENKINS_HOME"/jobs/AddCert_Base/config.xml
COPY ./setup/jobs/BundleCert_Base.xml "$JENKINS_HOME"/jobs/BundleCert_Base/config.xml
COPY ./setup/jobs/TriggerBuildIndex_Base.xml "$JENKINS_HOME"/jobs/TriggerBuildIndex_Base/config.xml
COPY ./setup/jobs/TriggerIndexReplica_Base.xml "$JENKINS_HOME"/jobs/TriggerIndexReplica_Base/config.xml
COPY ./setup/jobs/CreateTenant_Base.xml "$JENKINS_HOME"/jobs/CreateTenant_Base/config.xml
COPY ./setup/jobs/Utilities_DBClean_Base.xml "$JENKINS_HOME"/jobs/Utilities_DBClean_Base/config.xml
COPY ./setup/jobs/Utilities_UpdateDB_Base.xml "$JENKINS_HOME"/jobs/Utilities_UpdateDB_Base/config.xml
COPY ./setup/jobs/Utilities_VersionInfo_Base.xml "$JENKINS_HOME"/jobs/Utilities_VersionInfo_Base/config.xml
COPY ./setup/jobs/Utilities_StagingProp_Base.xml "$JENKINS_HOME"/jobs/Utilities_StagingProp_Base/config.xml
COPY ./setup/jobs/KubeExec_Base.xml "$JENKINS_HOME"/jobs/KubeExec_Base/config.xml
COPY ./setup/jobs/BuildCustomizationPackage_Base.xml "$JENKINS_HOME"/jobs/BuildCustomizationPackage_Base/config.xml
COPY ./setup/jobs/Utilities_DeployData_Base.xml "$JENKINS_HOME"/jobs/Utilities_DeployData_Base/config.xml


# Create KubeExec_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/KubeExec_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/KubeExec_Base/builds/1/

# Create DeployWCSCloud_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/DeployWCSCloud_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/DeployWCSCloud_Base/builds/1/

# Create BuildDockerImage_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/BuildDockerImage_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/BuildDockerImage_Base/builds/1/

# Create ManageConfigMap_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/ManageConfigMap_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/ManageConfigMap_Base/builds/1/

# Create ManageDockerfile_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/ManageDockerfile_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/ManageDockerfile_Base/builds/1/

# Create AddCert_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/AddCert_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/AddCert_Base/builds/1/

# Create BundleCert_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/BundleCert_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/BundleCert_Base/builds/1/

# Create TriggerBuildIndex_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/TriggerBuildIndex_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/TriggerBuildIndex_Base/builds/1/

# Create TriggerIndexReplica_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/TriggerIndexReplica_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/TriggerIndexReplica_Base/builds/1/

# Create ManageVaultConfig_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/ManageVaultConfig_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/ManageVaultConfig_Base/builds/1/

# Create CreateTenant_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/CreateTenant_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/CreateTenant_Base/builds/1/

# Create Utilities_DBClean job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_DBClean/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_DBClean/builds/1/

# Create Utilities_UpdateDB_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_UpdateDB_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_UpdateDB_Base/builds/1/

# Create Utilities_VersionInfo job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_VersionInfo_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_VersionInfo_Base/builds/1/

# Create Utilities_StagingProp job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_StagingProp_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_StagingProp_Base/builds/1/

# Create Utilities_DeployData job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_DeployData_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/Utilities_DeployData_Base/builds/1/

# Create BuildCustomizationPackage_Base job build number
RUN mkdir -p "$JENKINS_HOME"/jobs/BuildCustomizationPackage_Base/latest/
RUN mkdir -p "$JENKINS_HOME"/jobs/BuildCustomizationPackage_Base/builds/1/

# Add Jenkins Plugin Reference
COPY ./plugins.txt /usr/share/jenkins/ref
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy scirpt which used to detect the Vault
COPY ./vault.py /usr/local/bin

# Prime commerce-devops-utilites folder for utilities
COPY ./commerce-devops-utilities /commerce-devops-utilities
RUN chmod -R 755 /commerce-devops-utilities




