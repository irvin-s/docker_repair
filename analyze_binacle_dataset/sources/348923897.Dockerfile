FROM grahamc/jekyll

COPY . /src

CMD ["build", "--drafts"]