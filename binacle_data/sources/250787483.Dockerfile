# Based on desktop1604-test to give us a builder similar to the mozilla-central
# ones, and which has a window manager capability.
FROM          quay.io/mozilla/desktop1604-test

# Add any extra things we need, i.e. node 4.
ADD system-setup.sh /tmp/system-setup.sh
RUN bash /tmp/system-setup.sh

# Custom startup script to avoid mozharness.
ADD setup.sh /home/worker/bin/setup.sh
RUN chmod 755 /home/worker/bin/*
