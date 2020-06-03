# Inspired by:
# http://www.jamessturtevant.com/posts/Deploying-Python-Website-To-Azure-Web-with-Docker/#add-a-dockerfile

FROM python:3.5

RUN mkdir /pybotframework
ADD ./ /pybotframework/
WORKDIR /pybotframework/
RUN pip install -e .

EXPOSE 3978 443 80
ENTRYPOINT ["python", "/pybotframework/examples/eliza_bot/eliza_bot.py"]
