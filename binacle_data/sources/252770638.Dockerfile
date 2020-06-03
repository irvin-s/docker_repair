FROM cptactionhank/atlassian-jira:7.1.6  
# Add custom config  
ADD server.xml "/opt/atlassian/jira/conf/"  
  

