FROM python:2.7
MAINTAINER coopermaa77@gmail.com

# arduino for Arduino IDE distribution
# picocom for serial communication
# ino is a command line toolkit for working with Arduino hardware
RUN apt-get update && \
    apt-get install -y arduino picocom && \
    pip install ino

WORKDIR /app

# Define entry point and default command.
ENTRYPOINT ["ino"]
CMD ["--help"]
