FROM corebuild

# This image provides a Ruby 2.2 environment you can use to run your Ruby
# applications.

ENV RUBY_VERSION 2.2
ENV HTTPD_VERSION 2.4

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    INSTALL_PKGS="rh-ruby22 rh-ruby22-ruby-devel rh-ruby22-rubygem-rake v8314 rh-ruby22-rubygem-bundler nodejs010" && \
    yum install -y --nogpgcheck --setopt=tsflags=nodocs $INSTALL_PKGS && rpm -V $INSTALL_PKGS && \
    yum clean all -y

RUN chown -R 1001:0 /opt/app-root

EXPOSE 8080
USER 1001

ADD ./cmd.sh /

CMD ["/cmd.sh"]
