# Extend vert.x image
FROM ollin/vertx:latest

# Set the name of the verticle to deploy
ENV VERTICLE_NAME Server.scala

# Set the location of the verticles
ENV VERTICLE_HOME /usr/verticles

EXPOSE 1234

# Copy your verticle to the container
COPY $VERTICLE_NAME $VERTICLE_HOME/

# Launch the verticle
WORKDIR $VERTICLE_HOME
ENTRYPOINT ["sh", "-c"]
CMD ["vertx run $VERTICLE_NAME -cp $VERTICLE_HOME/*"]
