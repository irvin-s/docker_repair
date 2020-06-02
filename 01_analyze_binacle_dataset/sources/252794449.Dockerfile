FROM datacleansing/basejava  
  
# Copy application code.  
COPY . /app/  
  
# Install dependencies.  
RUN gradle build  

