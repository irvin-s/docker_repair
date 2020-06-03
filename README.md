The goal of this project is to localize posts on discussion forums with answers to build problems in Dockerfiles.

## Requirements.
Recent version of the following:

- `Docker`
- `Python3`
- `pip3`
- `Linux`

### 1. Build Dockerfiles

- Update the file `image_list.txt` with the Dockerfiles of your
interest. For reference, the file
`notes/sizesortedlist-dockerfiles.txt` contains the list of all
dockerfiles you can use (from binacle).

- Use the command below to build the dockerfiles. The generated logs
  will be located under directory `logs/`. Logs for build failures
  will be at `logs/fail` and logs of successful builds will be at
  `logs/success`.

```
  $>./build_test.sh
```

### 2. Generate Keywords from logs

- Before using the scripts install the requirements located in the `02_automated_keyword_generator/requirements.txt`
    - To install run this: `pip3 install -r requirements.txt`

- To automatic verify the failed logs run python script located at `02_automated_keyword_generator/`

- Run the python script using the following syntax:
    `python3 query_process.py ../logs/fail/228568839.log`

- Check the created keyword and the URLs for a possible repair at: `results/analyzed_query.json`

### 3. Process the keywords

 ## Pre-results

This repository work is in-flux, at this time there are only a few pre-results. The dataset of Dockerfiles must be in Context to avoid misconfiguration errors.
We are using TF-IDF to generate the keywords, first, we tried to use the RAKE algorithm, but we can't get good results.
