FROM andersrye/syntaxnet-forever

RUN pip install flask

WORKDIR /opt/tensorflow/models/syntaxnet/syntaxnet/models/parsey_universal

COPY download_models.sh .
RUN ./download_models.sh
#RUN curl http://download.tensorflow.org/models/parsey_universal/Norwegian.zip -o Norwegian.zip && unzip Norwegian.zip && rm Norwegian.zip
#RUN curl http://download.tensorflow.org/models/parsey_universal/English.zip -o English.zip && unzip English.zip && rm English.zip

#RUN git clone https://github.com/JoshData/parsey-mcparseface-server.git /opt/parsefaceserver
ADD . /opt/parsefaceserver/

WORKDIR /opt/tensorflow

CMD python /opt/parsefaceserver/server.py
