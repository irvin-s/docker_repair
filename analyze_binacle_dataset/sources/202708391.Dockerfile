# This is a comment
FROM amarburg/lsdslam-dev-host:conan-latest
MAINTAINER Aaron Marburg <amarburg@apl.washington.edu>

RUN apt-get install rake

RUN groupadd -r lsdslam && useradd -r -g lsdslam lsdslam
WORKDIR /home/lsdslam/lsd_slam
RUN chown -R lsdslam.lsdslam /home/lsdslam

USER lsdslam

#ENTRYPOINT ["rake"]
