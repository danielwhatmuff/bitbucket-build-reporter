# Bitbucket Cloud Build Status Reporter

## Update the Bitbucket  build statuses for commits from your CI jobs.

### Benefits
* Block pull requests from being merged if there is a failed build
* Link to the relevant build logs from within Bitbucket UI

### Notes
* Commit will be determined from the current directory if not supplied on command line
* URL and build number will default to jenkins environment variables if not supplied on command line
* Requires username and password with `repository` scope permission to access the required [API method](https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/statuses/build)

### Reference
```
usage: bb-report [-h] -o ORG -r REPO [-c COMMIT] [-U URL] [-n NUMBER] -s
                 {INPROGRESS,SUCCESSFUL,FAILED} -u USERNAME -p PASSWORD [-d]

Bitbucket Cloud Build Status Notifier

optional arguments:
  -h, --help            show this help message and exit
  -o ORG, --org ORG     Bitbucket org
  -r REPO, --repo REPO  Repository name
  -c COMMIT, --commit COMMIT
                        Commit sha
  -U URL, --url URL     Build URL
  -n NUMBER, --number NUMBER
                        CI build number
  -s {INPROGRESS,SUCCESSFUL,FAILED}, --state {INPROGRESS,SUCCESSFUL,FAILED}
                        State of the build
  -u USERNAME, --username USERNAME
                        Username for bitbucket
  -p PASSWORD, --password PASSWORD
                        Password for bitbucket
  -d, --debug           Debug mode
```

### Sanity test it against your Bitbucket account locally
```
$ cd your-repo/ # Required for determining a valid commit sha
$ bb-report -u 'https://your-ci.com' -nn 123 -s INPROGRESS -r <yourrepo> -u <bitbucket username> -p <bitbucket password> -o <bitbucket org>
```
