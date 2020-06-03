FROM mitchtech/rpi-gpio-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    git-core \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN pip install xmpppy pydns

RUN git clone git://github.com/mitchtech/raspi_gtalk_robot.git 

#[pinon|pon|on|high] [pin] : turns on the specified GPIO pin
#[pinoff|poff|off|low] [pin] : turns off the specified GPIO pin
#[write|w] [pin] [state] : writes specified state to the specified GPIO pin
#[read|r] [pin]: reads the value of the specified GPIO pin
#[available|online|busy|dnd|away|idle|out|xa] [arg1] : set gtalk state and status message to specified argument
#[shell|bash] [arg1] : executes the specified shell command argument after ‘shell’ or ‘bash’

WORKDIR /raspi_gtalk_robot

CMD ["python", "./raspiBot.py"]
