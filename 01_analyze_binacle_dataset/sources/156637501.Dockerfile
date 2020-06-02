FROM centos:latest
MAINTAINER The CentOS Project <admin@jiobxn.com>

ARG REDIS_SERVER="redhat.xyz"
ARG REDIS_PORT="16379"
ARG RUBY_V="2.3.1"
ARG GITLAB_V="8-14-stable"
#ARG WORKHORSE_V="v1.0.0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN epel_url="http://dl.fedoraproject.org/pub/epel/$(awk '{print $4}' /etc/redhat-release |awk -F. '{print $1}')/x86_64/e/" \
    && rpm -ivh $epel_url$(curl -s $epel_url |grep "epel-release" |awk -F\" '{print $6}') \
    && rpm -ivh http://repo.mysql.com/$(curl -s "http://dev.mysql.com/downloads/repo/yum/" |grep "noarch.rpm" |head -1 |grep -Po '(?<=\()[^)]*(?=\))')

RUN yum clean all; yum -y update; yum -y install openssh-server bash-completion vim wget iptables-services net-tools ntp cronie openssl make gcc-c++ \
    && yum -y install sudo expect zlib-devel openssl-devel ncurses-devel curl openssh-server logrotate curl-devel expat-devel gettext-devel perl-devel libyaml-devel gdbm-devel readline-devel libffi-devel libxml2-devel libxslt-devel libicu-devel python-docutils cmake nodejs \
    && yum -y install mysql-community-devel mysql-community-client strace postfix mailx; yum clean all

RUN cd /usr/local/src/ \
    && wget -c https://github.com/git/git/archive/$(curl -s https://github.com/git/git/releases |grep tag-name |head -1 |grep -Po '(?<=\>)[^)]*(?=\<)').tar.gz \
    && curl -O --progress https://cache.ruby-lang.org/pub/ruby/${RUBY_V:0:3}/ruby-${RUBY_V}.tar.gz \
    && curl -O --progress $(curl -s https://golang.org/dl/ |grep tar.gz |head -1 |awk -F\" '{print $4}') \
    && tar zxf v*.tar.gz \
    && tar xzf ruby-*.tar.gz \
    && tar -C /usr/local -xzf go*.tar.gz \
    && ln -sf /usr/local/go/bin/{go,godoc,gofmt} /usr/bin/ \
    && cd /usr/local/src/git-* \
    && make prefix=/usr all install \
    && cd /usr/local/src/ruby-* \
    && ./configure --disable-install-rdoc \
    && make -j8 \
    && make install \
	&& `#gem sources -r http://rubygems.org/ -a https://gems.ruby-china.org/` \
    && gem update \
    && gem install bundler --no-ri --no-rdoc \
	&& `#bundle config mirror.https://rubygems.org https://gems.ruby-china.org` \
    && ln -s /usr/local/bin/* /usr/bin/ \
    && sed -i 's/Defaults    requiretty/#Defaults    requiretty/' /etc/sudoers \
    && rm -rf /usr/local/src/*
	
RUN useradd git \
    && cd /home/git \
    && sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b ${GITLAB_V} gitlab \
    && cd /home/git/gitlab \
    && sudo -u git -H cp config/gitlab.yml.example config/gitlab.yml \
    && sudo -u git -H cp config/secrets.yml.example config/secrets.yml \
    && sudo -u git -H chmod 0600 config/secrets.yml \
    && sudo chown -R git log/ \
    && sudo chown -R git tmp/ \
    && sudo chmod -R u+rwX,go-w log/ \
    && sudo chmod -R u+rwX tmp/ \
    && sudo chmod -R u+rwX tmp/pids/ \
    && sudo chmod -R u+rwX tmp/sockets/ \
    && sudo -u git -H mkdir public/uploads/ \
    && sudo chmod 0700 public/uploads \
    && sudo chmod -R u+rwX builds/ \
    && sudo chmod -R u+rwX shared/artifacts/ \
    && sudo -u git -H cp config/unicorn.rb.example config/unicorn.rb \
    && sudo -u git -H cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb \
    && sudo -u git -H git config --global core.autocrlf input \
    && sudo -u git -H git config --global gc.auto 0 \
    && sudo -u git -H git config --global repack.writeBitmaps true \
    && sudo -u git -H cp config/resque.yml.example config/resque.yml \
    && sudo -u git cp config/database.yml.mysql config/database.yml \
    && sudo -u git -H bundle install --deployment --without development test postgres aws kerberos \
    && cd /home/git \
    && sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-workhorse.git \
    && cd gitlab-workhorse \
    && `#sudo -u git -H git checkout ${WORKHORSE_V}` \
    && sudo -u git -H make
    
RUN sed -i 's@unix:/var/run/redis/redis.sock@redis://'${REDIS_SERVER}':'${REDIS_PORT}'@' /home/git/gitlab/config/resque.yml \
    && cd /home/git/gitlab \
    && sudo -u git -H bundle exec rake gitlab:shell:install REDIS_URL=redis://${REDIS_SERVER}:${REDIS_PORT} RAILS_ENV=production SKIP_STORAGE_VALIDATION=true \
    && sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production \
    && sed -i 's@redis://'${REDIS_SERVER}':'${REDIS_PORT}'@unix:/var/run/redis/redis.sock@' /home/git/gitlab/config/resque.yml


VOLUME /home/git/repositories

COPY gitlab.sh /gitlab.sh
RUN chmod +x /gitlab.sh

ENTRYPOINT ["/gitlab.sh"]

EXPOSE 22 8080

CMD ["/usr/sbin/sshd", "-D"]

# docker build -t gitlab .
# docker run -d --restart always --privileged -p 2222:22 -p 8888:8080 -v /docker/gitlab:/home/git/repositories -e REDIS_SERVER=redhat.xyz -e DB_SERVER=redhat.xyz -e HTTP_SERVER=redhat.xyz --hostname gitlab --name gitlab gitlab
# docker logs -f gitlab