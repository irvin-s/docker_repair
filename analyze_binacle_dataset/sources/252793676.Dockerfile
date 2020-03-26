FROM ensime/ensime:v2.x-cache  
MAINTAINER Chip Senkbeil <chip.senkbeil@gmail.com>  
  
# Set desired JDK version  
RUN jenv global 1.8  
  
# Mark location of project to download  
ENV GIT_REPO https://github.com/ensime/scala-debugger.git  
ENV GIT_BRANCH master  
ENV GIT_SRC_DIR scala-debugger  
  
# Clone the main repository, build all sources (to get dependencies)  
# in a cache directory (so we can copy class files for use in  
# incremental compilation)  
WORKDIR /cache  
RUN git clone $GIT_REPO $GIT_SRC_DIR && \  
cd scala-debugger/ && \  
git checkout $GIT_BRANCH && \  
sbt +update +test:update +it:update  
  

