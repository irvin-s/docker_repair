FROM google/nodejs  
  
EXPOSE 8080  
# Copy application code.  
COPY . /app/  
  
# Install dependencies.  
RUN npm --unsafe-perm install  

