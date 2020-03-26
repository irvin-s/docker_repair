FROM library/ruby:2.5-slim  
  
  
RUN apt update \  
&& apt install -y --no-install-recommends build-essential \  
&& rm -rf /var/lib/apt/lists/*  
  
  
CMD ["irb"]

