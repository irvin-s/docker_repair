FROM ufoym/deepo:all-py36-jupyter

RUN pip install --upgrade pip
RUN pip install seaborn
RUN pip install tqdm
