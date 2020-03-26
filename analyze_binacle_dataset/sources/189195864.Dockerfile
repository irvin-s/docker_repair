FROM bigm/base-jdk7

ENV REPO_NAME puppetlabs-release-pc1-trusty.deb
RUN /xt/tools/_download /tmp/$REPO_NAME https://apt.puppetlabs.com/$REPO_NAME \
    && dpkg -i /tmp/$REPO_NAME \
    && rm -f /tmp/$REPO_NAME

RUN /xt/tools/_apt_install puppetserver \
    zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
RUN /opt/puppetlabs/puppet/bin/gem install r10k \
    && ln -s /opt/puppetlabs/puppet/bin/r10k /opt/puppetlabs/bin/

RUN /xt/tools/_install_admin_tools

RUN mv /etc/puppetlabs /etc/puppetlabs_orig
ADD startup/* /prj/startup/

ENV PATH /opt/puppetlabs/bin/:$PATH
EXPOSE 8140

CMD [ "/opt/puppetlabs/bin/puppetserver", "foreground" ]
