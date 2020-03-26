FROM spullara/java8:8u25
ADD auth.properties auth.properties
ADD teslalogger.jar teslalogger.jar
CMD ["java", "-cp", ".:telsalogger.jar", "teslalogger.DataLogger", "-h", "dev.corp.wavefront.com", "-p", "1", "-c", "auth.properties"]


