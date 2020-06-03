FROM centos:7
COPY hello_openshift /hello_openshift
EXPOSE 8080
ENTRYPOINT ["/hello_openshift"]
