FROM c12e/nodejs:8.9.4  
COPY . /from_ci_cd_build  
  
# Make sure the cortex executable is on the path ...  
RUN ln -s /from_ci_cd_build/bin/cortex.js /usr/local/bin/cortex  
  
ENTRYPOINT ["/from_ci_cd_build/entrypoint.sh"]  

