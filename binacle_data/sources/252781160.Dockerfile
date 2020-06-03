FROM clojure  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
RUN wget -q https://bitbucket.org/probprog/mlss2015/get/master.zip \  
&& unzip -q master.zip && rm master.zip  
WORKDIR probprog-mlss2015-aa10c3927338  
RUN lein deps  

