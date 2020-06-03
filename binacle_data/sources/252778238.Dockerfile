# extend the base image provided by OpenShift  
FROM openshift/base-centos7  
  
# ENV STI_SCRIPTS_PATH /usr/libexec/s2i  
# set labels used in OpenShift to describe the builder image  
LABEL \  
io.k8s.description="Platform for building Scala Play! applications" \  
io.k8s.display-name="scala-play" \  
io.openshift.expose-services="9000:http" \  
io.openshift.tags="builder,scala,play" \  
# location of the STI scripts inside the image.  
io.openshift.s2i.scripts-url=image://$STI_SCRIPTS_PATH  
  
# specify wanted versions of Java and SBT  
ENV JAVA_VERSION=1.8.0 \  
SBT_VERSION=0.13.15 \  
HOME=/opt/app-root/src \  
PATH=/opt/app-root/bin:$PATH  
  
# expose the default Play! port  
EXPOSE 9000  
  
# add the repository for SBT to the yum package manager  
COPY bintray--sbt-rpm.repo /etc/yum.repos.d/bintray--sbt-rpm.repo  
  
# install Java and SBT  
RUN yum install -y \  
java-${JAVA_VERSION}-openjdk \  
java-${JAVA_VERSION}-openjdk-devel \  
sbt-${SBT_VERSION} \  
postgresql && \  
yum clean all -y  
  
# initialize SBT  
RUN sbt -ivy ${HOME}/.ivy2 -debug about  
  
# copy the s2i scripts into the image  
COPY ./.s2i/bin $STI_SCRIPTS_PATH  
# chown the app directories to the correct user  
RUN chown -R 1001:0 $HOME && \  
chmod -R g+rw $HOME && \  
chmod -R g+rx $STI_SCRIPTS_PATH  
# switch to the user 1001  
USER 1001  
  
# show usage info as a default command  
CMD ["$STI_SCRIPTS_PATH/usage"]  

