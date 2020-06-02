FROM concourse/buildroot:git
MAINTAINER https://github.com/cloudfoundry/bosh-deployment-resource

ADD check /opt/resource/check
ADD in /opt/resource/in
ADD out /opt/resource/out

RUN chmod +x /opt/resource/*