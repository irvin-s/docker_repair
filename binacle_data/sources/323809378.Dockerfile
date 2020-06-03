FROM java:8-jre

ADD challenge.jar /

CMD java -jar /challenge.jar
