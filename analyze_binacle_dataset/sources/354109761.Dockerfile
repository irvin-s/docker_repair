FROM 0x0l/jupyter:latest

RUN pip3 install -q nltk
RUN python3 -m nltk.downloader -d /usr/local/share/nltk_data \
  bllip_wsj_no_aux \
  book \
  gazetteers \
  large_grammars \
  sample_grammars \
  senseval \
  sentence_polarity \
  sentiwordnet \
  subjectivity \
  twitter_samples \
  vader_lexicon \
  verbnet \
  word2vec_sample
