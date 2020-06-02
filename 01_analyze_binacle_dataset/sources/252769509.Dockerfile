from ansrivas/scala-sbt:2_11_11-1_0_1  
# Copy all the code in here  
COPY . /lib  
  
RUN useradd -ms /bin/bash app && \  
chown -R app:app /lib  
  
USER app  
  
WORKDIR /lib  
# Create a fat jar and clean up rest  
RUN sbt clean compile assembly && \  
rm -rf /lib/target && \  
rm -rf ~/.ivy2 && \  
rm -rf ~/.sbt  
  
CMD java -jar /lib/dist/main.jar /lib/dataset  

