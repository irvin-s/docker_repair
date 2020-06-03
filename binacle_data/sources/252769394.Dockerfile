#cd replication docker image  
FROM ubuntu:latest  
COPY /Data /tmp/cd_data/  
COPY /Models /tmp/cd_models/  
COPY /Survey /tmp/cd_survey/  
COPY /Figures /tmp/figures/  
COPY README.md /tmp/  

