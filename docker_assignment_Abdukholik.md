## Task 1.1

## Task 1.2 - Failed run
ModuleNotFoundError: No module named pandas

## Task 1.2 - Fixed run
Python 3.9, pandas 1.5.3

## Final Dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install numpy==1.24.3 pandas==1.5.3
COPY hello.py .
CMD [python, hello.py]

## Question 2.1 - Why pin?
If you write RUN pip install pandas without a version, pip installs the latest version available at build time. Six months later, a newer pandas version may be released with breaking changes. Anyone who builds your Dockerfile then gets a different pandas and potentially different results or errors. Reproducibility breaks not immediately, but silently over time.

## Question 2.2 - Recipe or cake?
Sending the Dockerfile and hello.py is better for reproducible research because anyone can inspect exactly what environment is being created. A built image is a black box; the Dockerfile is transparent, auditable, and version-controllable in Git.
