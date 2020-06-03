FROM ubuntu:trusty

# installation dependencies
RUN apt-get update -y && apt-get install -y wget openjdk-7-jre-headless gstreamer1.0-tools gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly

# setup app user and directory
RUN yes | adduser app
ADD . /home/app
RUN chown -R app /home/app
WORKDIR /home/app
USER app

# go!
CMD java -jar target/semira.jar
EXPOSE 8080
