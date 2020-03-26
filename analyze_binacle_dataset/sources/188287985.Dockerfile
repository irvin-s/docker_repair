# Begin from Kurma stage3
FROM apcera/kurma-stage3

# Ensure TMPDIR is set. This is necessary for Go, for one.
ENV TMPDIR /tmp

# Run the build.
COPY build.sh /tmp/
RUN chmod a+x /tmp/build.sh && /tmp/build.sh && rm /tmp/build.sh
