# Ensure Jenkins starts and runs
RUN java -jar /usr/share/jenkins/jenkins.war& \
    sleep 1m && \
    curl http://127.0.0.1:8080
