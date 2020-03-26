# Not sure if there's an official OpenAI universe image
# hosted somewhere, this one is built directly from their repo:
# https://github.com/openai/universe
FROM alantrrs/openai-universe 

COPY . /code
WORKDIR /code

ENTRYPOINT python main.py
