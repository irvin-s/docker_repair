FROM openjdk:8-jdk

# The Dockerfile bundles an R5 jar with transit data
# and starts the GraphQL server for processing router requests.

# This assumes that you have run
# mvn package
# java -Xmx8g -classpath ./target/r5build.jar com.conveyal.r5.R5Main point --build ./totx_transit_data one-to-many toronto-das.locations.txt
# before deploying the Docker image. The reason is that the --build step can take 4-8 minutes and
# the Docker image would be unavailable for a while after deployment, which makes detecting an
# actual problem more difficult.

ADD ./totx_transit_data/ /totx_transit_data/
ADD ./target/ /target/


EXPOSE 8080
CMD java -XX:+PrintFlagsFinal -XX:+PrintGCDetails -Xmx8g -classpath ./target/r5build.jar com.conveyal.r5.R5Main point --graphs ./totx_transit_data one-to-many toronto-das.locations.txt
