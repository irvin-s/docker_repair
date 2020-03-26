FROM ubuntu

# Add logbomb user and group
RUN adduser --system \
	--shell /bin/bash \
	--disabled-password \
	--home /opt/logbomb \
	--group \
	logbomb

COPY . /

# Fix some permission since we'll be running as a non-root user
RUN chown -R logbomb:logbomb /opt/logbomb

USER logbomb

CMD ["/opt/logbomb/sbin/logbomb"]
