The goal of this project is to localize posts on discussion forums
with answers to build problems in Dockerfiles.

## Requirements.
Recent version of the following:

- `Docker`
- `Python3`
- `pip3`
- `Linux`

### 1. Build Dockerfiles

- Update the file `image_list.txt` with the Dockerfiles of your
interest. For reference, the file
`${ROOT_DIR}/notes/sizesortedlist-dockerfiles.txt` contains the list of all
dockerfiles you can use (from binacle).

- Use the command below to build the dockerfiles. The generated logs
  will be located under directory `logs/`. Logs for build failures
  will be at `logs/fail` and logs of successful builds will be at
  `logs/success`.

```
  $>./build_test.sh
```

### 2. Generate Keywords from logs

- cd to directory `keyword_gen` 

- install requirements

```
pip3 install -r requirements.txt
```

- The following script processes a given log file, generating results
  at `${ROOT_DIR}/results/analyzed_query.json`.

```
python3 query_process.py <log-file-of-failing-build>
```

For example:

```
python3 query_process.py ${ROOT_DIR}/logs/fail/228568839.log
```

- Check the created keyword and the URLs for a possible repair at: 

### 3. Process the keywords

## Pre-results

This repository work is in-flux, at this time there are only a few pre-results. The dataset of Dockerfiles must be in Context to avoid misconfiguration errors.
We are using TF-IDF to generate the keywords, first, we tried to use the RAKE algorithm, but we can't get good results.
