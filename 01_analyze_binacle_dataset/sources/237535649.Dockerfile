FROM apereo/cas:v5.0.1

RUN mkdir -p /cas-overlay/src/main/java/org/apereo/cas/authentication/handler/support

ADD pom_xml.txt /cas-overlay/pom.xml
ADD AbstractUsernamePasswordAuthenticationHandler.java /cas-overlay/src/main/java/org/apereo/cas/authentication/handler/support/AbstractUsernamePasswordAuthenticationHandler.java
ADD QueryDatabaseAuthenticationHandler.java /cas-overlay/src/main/java/org/apereo/cas/adaptors/jdbc/QueryDatabaseAuthenticationHandler.java


RUN ./build.sh package
