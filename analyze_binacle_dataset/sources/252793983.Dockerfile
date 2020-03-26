FROM gitlab/gitlab-runner:v9.3.0  
COPY wrapper /wrapper  
RUN chmod +x /wrapper  
  
ENTRYPOINT ["/wrapper"]  
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]  

