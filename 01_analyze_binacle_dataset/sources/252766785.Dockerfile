FROM alanedwardes/docker-s3fs:latest  
  
# Ensure packages are up to date  
RUN apt-get -qq update  
  
# Install pre-reqs  
RUN apt-get -qq install subversion  
  
# Copy run script  
ADD svnserve.sh /svnserve.sh  
  
# Change perms to execute  
RUN chmod +x /svnserve.sh  
  
# Expose the SVN port  
EXPOSE 3690  
# Run script  
CMD ["/svnserve.sh"]

