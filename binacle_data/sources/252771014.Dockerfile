FROM postgres:latest  
MAINTAINER Adrian Haasler García <dev@adrianhaasler.com>  
  
# Add authentication initialization file  
COPY authentication.sh /docker-entrypoint-initdb.d/authentication.sh  
  
# Add Jira database initialization file  
COPY jira.sh /docker-entrypoint-initdb.d/jira.sh  
  
# Default configuration  
ENV JIRA_DB_NAME jiradb  
ENV JIRA_DB_USER jira  
ENV JIRA_DB_PASS password  

