FROM italiangrid/pkg.base:centos7

COPY EGI-trustanchors.repo /etc/yum.repos.d/

RUN sudo yum -y install epel-release && sudo yum -y update && \
      sudo yum -y install ca-policy-egi-core fetch-crl && \
      sudo fetch-crl || true
RUN git clone https://github.com/andreaceccanti/test-ca && \
      cd test-ca && make  && \
      sudo yum -y localinstall igi-test-ca/rpmbuild/RPMS/noarch/*.rpm

VOLUME /etc/grid-security/certificates
