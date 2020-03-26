FROM ubuntu

# Add logbomb user and group
RUN adduser --system \
	--shell /bin/bash \
	--disabled-password \
	--home /opt/logarchiver \
	--group \
	logarchiver

COPY . /

# Fix some permission since we'll be running as a non-root user
RUN chown -R logarchiver:logarchiver /opt/logarchiver

USER logarchiver

CMD ["/opt/logarchiver/bin/logarchiver"]
