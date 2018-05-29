FROM python:2

RUN pip install bitbucket-build-reporter

CMD ["bb-report"]
