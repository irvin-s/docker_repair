FROM debian:jessie
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>
MAINTAINER Jean-Marc MEESSEN <jean-marc@meessen-web.org>

ENV DEBIAN_FRONTEND noninteractive
ENV IDEA_VERSION=2016.1.4
ENV MAVEN_VERSION=3.3.9
ENV FIREFOX_VERSION=48.0.1

COPY configs/x2go.list /etc/apt/sources.list.d/x2go.list
COPY configs/idea.desktop /usr/share/applications/idea.desktop
COPY configs/idea.png /opt/idea/idea.png
COPY configs/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY configs/user-env.sh /etc/profile.d/user-env.sh
COPY configs/firefox.desktop /usr/share/applications/firefox.desktop
COPY configs/idea.desktop /usr/share/applications/idea.desktop
COPY configs/idea.png /opt/idea/idea.png

RUN apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E \
  && apt-get -q update \
  && apt-get install -q -y --no-install-recommends \
    aptitude \
    byobu \
    build-essential \
    curl \
    git \
    htop \
    libasound2 \
    libdbus-glib-1-2 \
    libgtk2.0-0 \
    libpango1.0-0 \
    libxt6 \
    libXrender1 \
    lxde \
    openjdk-7-jdk \
    openssh-server \
    software-properties-common \
    sudo \
    vim \
    wget \
    x2goserver \
    x2golxdebindings \
    x2goserver-xsession \
    x2go-keyring

 RUN  apt-get remove -q -y iceweasel \
  && echo "root:root" | chpasswd \
  && adduser --disabled-password --gecos "" dockerx \
  && adduser dockerx sudo \
  && echo "dockerx:dockerx" | chpasswd \
  && adduser dockerx x2gouser \
  && echo "dockerx ALL = NOPASSWD: ALL" > /etc/sudoers.d/dockerx \
  && mkdir -p /var/run/sshd /opt/maven /home/dockerx/.ssh /data /home/dockerx/.config/lxpanel/LXDE/panels /home/dockerx/.m2 \
  && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
  && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
  && sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config \
  && sed -i "s/#AuthorizedKeysFile/AuthorizedKeysFile/g" /etc/ssh/sshd_config \
  && curl -L -o /tmp/idea.tgz https://download.jetbrains.com/idea/ideaIC-${IDEA_VERSION}.tar.gz \
  && tar -xzf /tmp/idea.tgz -C /opt/ \
  && cp -r /opt/idea-*/* /opt/idea/ \
  && ln -s /opt/idea/bin/idea.sh /usr/local/bin/ \
  && curl -L -o /tmp/maven.tgz http://apache.belnet.be/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && tar xzf /tmp/maven.tgz -C /opt/maven \
  && ln -s "/opt/maven/apache-maven-${MAVEN_VERSION}" /opt/maven/maven-latest \
  && ln -s /opt/maven/maven-latest/bin/mvn /usr/local/bin/ \
  && curl -L -o /tmp/firefox.tar.bz2 http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2 \
  && tar jxf /tmp/firefox.tar.bz2 -C /opt/ \
  && ln -s /opt/firefox/firefox /usr/local/bin/ \
  && echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" \
    > /home/dockerx/.ssh/authorized_keys \
  && chmod 1777 /dev/shm \
  && chown -R dockerx:dockerx /data /home/dockerx \
  && chmod -R 0750 /data /home/dockerx \
  && chmod 0700 /home/dockerx/.ssh \
  && chmod 0600 /home/dockerx/.ssh/authorized_keys \
  && chmod a+x /usr/local/bin/entrypoint.sh \
  && apt-get -qy autoremove \
  && apt-get -qy purge \
  && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/* /opt/idea-*

USER dockerx
COPY configs/lxde-main-panel /home/dockerx/.config/lxpanel/LXDE/panels/panel
COPY configs/settings.xml /home/dockerx/.m2/settings.xml
COPY demoMaterial/setupDemo.sh /data/setupDemo.sh

# Define working directory.
WORKDIR /data

# Mark as data volumes those folder
VOLUME ["/data","/var/log","/tmp","/var/cache"]

EXPOSE 22

CMD ["/usr/local/bin/entrypoint.sh"]
