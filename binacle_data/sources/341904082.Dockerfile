FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "neovim"]
CMD ["python", "snippet.py"]