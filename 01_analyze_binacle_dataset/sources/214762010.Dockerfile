# DOCKER-VERSION 1.0.1
FROM ggotti/aem-base
MAINTAINER ggotti

#Copies required build media
ONBUILD ADD cq-author-4502.jar /aem/cq-author-4502.jar
ONBUILD ADD license.properties /aem/license.properties
ONBUILD ADD https://raw.githubusercontent.com/ggotti/aem-author/master/postInstallHook.py /aem/postInstallHook.py

# Extracts AEM
ONBUILD WORKDIR /aem
ONBUILD RUN java -XX:MaxPermSize=256m -Xmx1024M -jar cq-author-4502.jar -unpack -r nosamplecontent

# Add customised log file, to print the logging to standard out.
ONBUILD ADD https://raw.githubusercontent.com/ggotti/aem-author/master/org.apache.sling.commons.log.LogManager.config /aem/crx-quickstart/install/

# Installs AEM
ONBUILD RUN ["python","aemInstaller.py","-i","cq-author-4502.jar","-r","author","-p","4502"]

EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]
