
RUN pip install spacy==2.0.18
RUN python -m spacy download en
RUN python -m spacy download de
RUN python -m spacy download es
RUN python -m spacy download pt
RUN python -m spacy download fr
RUN python -m spacy download it
RUN python -m spacy download nl