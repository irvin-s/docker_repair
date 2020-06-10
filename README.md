# Automatic Dockerfiles repair
 This tool tries to localize posts on discussion forums
with answers to build problems in Dockerfiles.

 ## Usage / Setup
To use the automatic Dockerfiles repair, use Linux, and install the following requirements.

- Latest version: 

- `Docker`
- `Python3`
- `pip3`
- `Linux`

- Install our requirements:

```
pip3 install -r requirements.txt
```

### 01 - Build Dockerfiles

- Before executing the building, insert the Dockerfiles names in: `image_list.txt`

- To select what Dockerfiles to build see: `${ROOT_DIR}/notes/sizesortedlist-dockerfiles.txt`
    - The filename must have this format `sources/228568839.Dockerfile`

- To build Dockerfiles run the script:
    `./build_test.sh`

- After run the script see Logs at: `${ROOT_DIR}/logs/`
    - Logs for build failure `${ROOT_DIR}/logs/fail` and success `${ROOT_DIR}/logs/success`

### 02 - Generate Keywords from logs

- cd to directory `${ROOT_DIR}/query_proc`

- The following script processes a log file to generate a list of keywords and URLs 
that contains fix recommendations.

```
python3 keyword_creator.py <log-file-of-failing-build>
```

For example:

```
python3 keyword_creator.py ${ROOT_DIR}/logs/fail/228568839.log
```

### 03 - Check query results

- Check the output at: 

```
${ROOT_DIR}/results/analyzed_query.json.
```

 ## Preliminaries

This repository work is in-flux, at this time there are only a few pre-results. The dataset of Dockerfiles must be in Context to avoid misconfiguration errors. We are using TF-IDF to generate the keywords, first, we tried to use the RAKE algorithm, but we can't get good results.