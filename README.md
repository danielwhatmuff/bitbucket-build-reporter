# Bitbucket Cloud Build Status Reporter

## Update the Bitbucket build statuses for commits from your CI jobs.
![](https://raw.githubusercontent.com/danielwhatmuff/bitbucket-build-reporter/master/img/img-1.png)
![](https://raw.githubusercontent.com/danielwhatmuff/bitbucket-build-reporter/master/img/img-2.png)
![](https://raw.githubusercontent.com/danielwhatmuff/bitbucket-build-reporter/master/img/img-3.png)

### Benefits
* Block pull requests from being merged if there is a failed build
* Link to the relevant build logs from within Bitbucket UI

### Notes
* Commit will be determined from the current directory if not supplied on command line
* URL and build number will default to jenkins environment variables if not supplied on command line
* Requires username and password with `repository` scope permission to access the required [API method](https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/statuses/build)

### Usage examples
* If you use Travis CI (.org)
```yaml
...
before_script:
  - bb-report -c $TRAVIS_COMMIT -U "https://travis-ci.org/$TRAVIS_REPO_SLUG/builds/$TRAVIS_BUILD_ID" -n $TRAVIS_BUILD_NUMBER -s INPROGRESS -r <yourrepo> -u $BITBUCKET_USERNAME -p $BITBUCKET_PASSWORD -o <bitbucket org>
script:
  - python your-tests.py
after_failure:
  - bb-report -c $TRAVIS_COMMIT -U "https://travis-ci.org/$TRAVIS_REPO_SLUG/builds/$TRAVIS_BUILD_ID" -n $TRAVIS_BUILD_NUMBER -s FAILED -r <yourrepo> -u $BITBUCKET_USERNAME -p $BITBUCKET_PASSWORD -o <bitbucket org>
after_success:
  - bb-report -c $TRAVIS_COMMIT -U "https://travis-ci.org/$TRAVIS_REPO_SLUG/builds/$TRAVIS_BUILD_ID" -n $TRAVIS_BUILD_NUMBER -s SUCCESSFUL -r <yourrepo> -u $BITBUCKET_USERNAME -p $BITBUCKET_PASSWORD -o <bitbucket org>
...
```
* If you use 

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
$ pip install bitbucket-build-reporter
$ cd your-repo/ # Required for determining a valid commit sha
$ bb-report -U 'https://your-ci.com' -n 123 -s INPROGRESS -r <yourrepo> -u <bitbucket username> -p <bitbucket password> -o <bitbucket org>
```
