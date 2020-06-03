# Begin from KurmaOS stage4
FROM apcera/kurmaos-stage4

# Run the build.
COPY build.sh kernel.defconfig patches /tmp/
RUN /tmp/build.sh && rm /tmp/build.sh
