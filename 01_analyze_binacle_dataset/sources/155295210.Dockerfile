FROM mattrix/teamcity-java

# Expose the default TeamCity Server port
EXPOSE 8111

# Start the TeamCity Server
ENTRYPOINT /usr/local/TeamCity/bin/teamcity-server.sh run
