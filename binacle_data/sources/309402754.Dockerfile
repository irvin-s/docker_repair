FROM python

# Install dependencies
RUN pip install -U numpy scipy scikit-learn pandas

# Add our code
ADD train.py /code/train.py
