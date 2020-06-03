FROM debian:jessie  
  
ENV STASH_HOME /var/atlassian/application-data/stash  
  
RUN mkdir -p "${STASH_HOME}" \  
mkdir "${STASH_HOME}/lib" \  
&& chmod -R 700 "${STASH_HOME}" \  
&& chown -R daemon:daemon "${STASH_HOME}"  
  
USER daemon  
  
VOLUME ${STASH_HOME}  
  
CMD ["echo", "Data container for Atlassian Stash"]  

