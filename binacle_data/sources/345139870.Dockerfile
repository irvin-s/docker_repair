From uday/jenkins-base
MAINTAINER Udaypal Aarkoti <uaarkoti@gmail.com>

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$CATALINA_HOME/jobs"

ADD https://updates.jenkins-ci.org/latest/mock-security-realm.hpi /var/lib/jenkins/plugins/mock-security-realm.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-aggregator.hpi /var/lib/jenkins/plugins/workflow-aggregator.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-basic-steps.hpi /var/lib/jenkins/plugins/workflow-basic-steps.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-scm-step.hpi /var/lib/jenkins/plugins/workflow-scm-step.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-step-api.hpi /var/lib/jenkins/plugins/workflow-step-api.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-cps.hpi /var/lib/jenkins/plugins/workflow-cps.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-job.hpi /var/lib/jenkins/plugins/workflow-job.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-cps-global-lib.hpi /var/lib/jenkins/plugins/workflow-cps-global-lib.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-api.hpi /var/lib/jenkins/plugins/workflow-api.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-durable-task-step.hpi /var/lib/jenkins/plugins/workflow-durable-task-step.hpi
ADD https://updates.jenkins-ci.org/latest/workflow-support.hpi /var/lib/jenkins/plugins/workflow-support.hpi
ADD https://updates.jenkins-ci.org/latest/durable-task.hpi /var/lib/jenkins/plugins/durable-task.hpi
ADD https://updates.jenkins-ci.org/latest/git-server.hpi /var/lib/jenkins/plugins/git-server.hpi
ADD https://updates.jenkins-ci.org/latest/git-client.hpi /var/lib/jenkins/plugins/git-client.hpi
ADD https://updates.jenkins-ci.org/latest/git.hpi /var/lib/jenkins/plugins/git.hpi
ADD https://updates.jenkins-ci.org/latest/mailer.hpi /var/lib/jenkins/plugins/mailer.hpi
ADD https://updates.jenkins-ci.org/latest/scm-api.hpi /var/lib/jenkins/plugins/scm-api.hpi
ADD https://updates.jenkins-ci.org/latest/promoted-builds.hpi /var/lib/jenkins/plugins/promoted-builds.hpi
ADD https://updates.jenkins-ci.org/latest/matrix-project.hpi /var/lib/jenkins/plugins/matrix-project.hpi
ADD https://updates.jenkins-ci.org/latest/ssh-credentials.hpi /var/lib/jenkins/plugins/ssh-credentials.hpi
ADD https://updates.jenkins-ci.org/latest/credentials.hpi /var/lib/jenkins/plugins/credentials.hpi

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
	05AB33110949707C93A279E3D3EFE6B686867BA6 \
	07E48665A34DCAFAE522E5E6266191C37C037D42 \
	47309207D818FFD8DCD3F83F1931D684307A10A5 \
	541FBE7D8F78B25E055DDEE13C370389288584E7 \
	61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
	79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
	80FF76D88A969FE46108558A80B953A041E49465 \
	8B39757B1D8A994DF2433ED58B3A601F08C975E5 \
	A27677289986DB50844682F8ACB77FC2E86E29AC \
	A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
	B3F49CD3B9BD2996DA90F817ED3873F5D3262722 \
	DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
	F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
	F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23

ENV TOMCAT_MAJOR 6
ENV TOMCAT_VERSION 6.0.44
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN set -x \
	&& curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz*

ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD server.xml /usr/local/tomcat/conf/
ADD jobs /var/lib/jenkins/jobs
ADD workflow-libs /var/lib/jenkins/workflow-libs

ENV JAVA_HOME /usr/lib/jvm/jre
RUN export JAVA_HOME=$JAVA_HOME

RUN chown -R jenkins:jenkins /var/lib/jenkins/plugins
RUN chown -R jenkins:jenkins /var/lib/jenkins/jobs
CMD service jenkins start; bin/catalina.sh run;

EXPOSE 8080 8180
