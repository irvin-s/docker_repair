FROM centurylink/ca-certs
WORKDIR /
ADD neutron-docker /neutron
ADD public/build /public/build
CMD ["/neutron"]
EXPOSE 4000
