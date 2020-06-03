FROM octohost/ruby-2.0

RUN gem install remote_syslog --no-ri --no-rdoc

ENTRYPOINT ["/usr/local/bin/remote_syslog", "-D"]
CMD []
