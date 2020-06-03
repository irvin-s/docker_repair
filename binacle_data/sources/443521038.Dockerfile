FROM quay.io/democracyworks/clojure-api:latest

# the WORKDIR will be added to the container as a volume by the build script
WORKDIR /s3-ftp
CMD ["lein", "with-profile", "build", "uberjar"]
