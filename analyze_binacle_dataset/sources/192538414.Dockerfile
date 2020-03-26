# Begin from Gentoo stage3
FROM apcera/kurmaos-stage3

# Ensure TMPDIR is set. This is necessary for Go, for one.
ENV TMPDIR /tmp

# Run the build.
COPY build.sh /tmp/
RUN /tmp/build.sh && rm /tmp/build.sh
