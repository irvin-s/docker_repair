FROM java:jre-alpine  
  
MAINTAINER Pascal Maximilian Bremer <maximilian at cdsffo.de>  
  
RUN apk add --update --no-cache \  
unzip \  
wget  
  
RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2016-10-31.zip  
RUN unzip stanford-corenlp-full-2016-10-31.zip && \  
rm stanford-corenlp-full-2016-10-31.zip  
  
WORKDIR stanford-corenlp-full-2016-10-31  
  
RUN export CLASSPATH="`find . -name '*.jar'`"  
  
ENV PORT 9000  
EXPOSE $PORT  
  
CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer  

