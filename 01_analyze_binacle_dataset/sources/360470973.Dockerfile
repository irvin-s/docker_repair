FROM scratch
MAINTAINER Ferran Rodenas <frodenas@gmail.com>

# Add files
ADD rds-broker /rds-broker
ADD config.json /config.json

# Command to run
ENTRYPOINT ["/rds-broker"]
CMD ["--config=/config.json"]

# Expose listen ports
EXPOSE 3000
