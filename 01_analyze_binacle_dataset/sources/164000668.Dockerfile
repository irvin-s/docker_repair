# Trim whitespace test
# See issue #13
FROM dockerfile/java:oracle-java6 
 RUN curl -o XXX.jar YYYY.jar
CMD java -jar XXX.jar
EXPOSE 9324