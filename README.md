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
  will be located under directory `${ROOT_DIR}logs/`. Logs for build failures
  will be at `${ROOT_DIR}logs/fail` and logs of successful builds will be at
  `${ROOT_DIR}logs/success`.

```
  $>./build_test.sh
```

### 2. Generate keywords

- cd to directory `${ROOT_DIR}/keyword_gen/` 

- Install requirements

```
pip3 install -r requirements.txt
```

- Extract the keywords. The following script processes a log file to generate a list of keywords.

```
python3 keyword_creator.py <log-file-of-failing-build>
```

For example:

```
python3 keyword_creator.py ${ROOT_DIR}/logs/fail/228568839.log
```

- Check the output at `${ROOT_DIR}/results/generated_keywords.txt`.

### 3. Generate query (from keywords) and process results

- cd to directory `${ROOT_DIR}/query_proc/`

- Process the keywords. The following script search the web for URLs.

```
python3 query_process.py 
```

- Check the output at `${ROOT_DIR}/results/analyzed_query.json`.
