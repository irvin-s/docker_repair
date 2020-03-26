FROM node:8.7.0-alpine  
  
LABEL maintainer="headcr4sh@gmail.com" \  
version="1.0.0"  
  
COPY "sonarqube-qualitygate-check.js" "/opt/sonarqube-qualitygate-check/"  
COPY "sonarqube-qualitygate-check-cli.js" "/opt/sonarqube-qualitygate-check/"  
COPY "sonarqube-qualitygate-check.sh" "/sonarqube-qualitygate-check"  
  
RUN chmod +x /sonarqube-qualitygate-check  
  
ENV WORKDIR= \  
CE_TASK_FILE="ce_task.json" \  
QUALITYGATE_PROJECT_STATUS_FILE="qualitygate_project_status.json"  
  
WORKDIR /  
  
ENTRYPOINT [ "/sonarqube-qualitygate-check" ]

