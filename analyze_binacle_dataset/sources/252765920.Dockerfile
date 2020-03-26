FROM jenkinsci/jenkins:latest  
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>  
  
LABEL Description="Jenkins container with docker.io binary" \  
Vendor="ACME Products" \  
Version="1.0"  
  
ENV DOCKER_HOST 172.17.0.1:4243  
  
USER root  
  
RUN set -e; \  
wget -qO- \  
https://releases.rancher.com/cli/v0.4.1/rancher-linux-amd64-v0.4.1.tar.gz \  
| tar xzv \  
-C /usr/local/bin \  
\--strip-components=2  
  
RUN set -e; \  
apt-get update; \  
apt-get install -y docker.io;  
  
RUN /usr/local/bin/install-plugins.sh \  
bouncycastle-api \  
structs \  
junit \  
antisamy-markup-formatter \  
pam-auth \  
windows-slaves \  
display-url-api \  
mailer \  
ldap \  
token-macro \  
external-monitor-job \  
icon-shim \  
matrix-auth \  
script-security \  
matrix-project \  
build-timeout \  
credentials \  
workflow-step-api \  
plain-credentials \  
credentials-binding \  
timestamper \  
workflow-api \  
workflow-basic-steps \  
resource-disposer \  
ws-cleanup \  
ant \  
gradle \  
pipeline-milestone-step \  
workflow-support \  
pipeline-build-step \  
jquery-detached \  
pipeline-input-step \  
ace-editor \  
workflow-scm-step \  
scm-api \  
workflow-cps \  
pipeline-stage-step \  
workflow-job \  
pipeline-graph-analysis \  
pipeline-rest-api \  
handlebars \  
momentjs \  
pipeline-stage-view \  
ssh-credentials \  
git-client \  
git-server \  
workflow-cps-global-lib \  
branch-api \  
workflow-multibranch \  
durable-task \  
workflow-durable-task-step \  
workflow-aggregator \  
github-api \  
git \  
github \  
github-branch-source \  
github-organization-folder \  
mapdb-api \  
subversion \  
ssh-slaves \  
email-ext \  
cloudbees-folder \  
authentication-tokens \  
docker-commons \  
yet-another-docker-plugin \  
python \  
javadoc \  
maven-plugin \  
cobertura \  
violations \  
parallel-test-executor \  
buildresult-trigger;  
  
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state  
  
USER jenkins  

