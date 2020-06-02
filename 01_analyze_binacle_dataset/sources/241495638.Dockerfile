FROM nerdalize/nerd

ADD entrypoint.sh /entrypoint.sh

# Add your own Dockerfile commands

ENTRYPOINT /entrypoint.sh
