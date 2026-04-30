# Docker Assignment

## Part 1. Mechanics

### Task 1.1 — Change the Python version

```text
$ docker build -t hello-docker . 
[+] Building 1.2s (9/9) FINISHED                       docker:desktop-linux
 => [internal] load build definition from Dockerfile                   0.0s
 => => transferring dockerfile: 114B                                   0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim     1.1s
 => [auth] library/python:pull token for registry-1.docker.io          0.0s
 => [internal] load .dockerignore                                      0.0s
 => => transferring context: 2B                                        0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16b  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16b  0.0s
 => [internal] load build context                                      0.0s
 => => transferring context: 144B                                      0.0s
 => CACHED [2/3] WORKDIR /app                                          0.0s
 => [3/3] COPY hello.py .                                              0.0s
 => exporting to image                                                 0.0s
 => => exporting layers                                                0.0s
 => => exporting manifest sha256:f7c1720a07a28701c785f108185726f3bab8  0.0s
 => => exporting config sha256:1f70e4cdb8d1d7554071e53f739b3df1d69a96  0.0s
 => => exporting attestation manifest sha256:21b7afe0c5d4b3fc0e92e11f  0.0s
 => => exporting manifest list sha256:c480cb51053b41d9f541eb69aa60859  0.0s
 => => naming to docker.io/library/hello-docker:latest                 0.0s
 => => unpacking to docker.io/library/hello-docker:latest              0.0s

$ docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

# Task 1.2 — Break and fix the Dockerfile

# Failed run:

```Plaintext
$ docker build -t hello-docker . 
[+] Building 0.4s (8/8) FINISHED                       docker:desktop-linux
 => [internal] load build definition from Dockerfile                   0.0s
...
 => => naming to docker.io/library/hello-docker:latest                 0.0s
 => => unpacking to docker.io/library/hello-docker:latest              0.0s

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'
Successful run:
```

```Plaintext
$ docker build -t hello-docker . 
[+] Building 23.9s (9/9) FINISHED                      docker:desktop-linux
 => [internal] load build definition from Dockerfile                   0.0s
...
 => [3/4] RUN pip install pandas==2.2.0                               19.3s
 => [4/4] COPY hello.py .                                              0.0s 
 => exporting to image                                                 4.1s 
...
 => => naming to docker.io/library/hello-docker:latest                 0.0s
 => => unpacking to docker.io/library/hello-docker:latest              0.7s

$ docker run --rm hello-docker
Python 3.9, pandas 2.2.0
/app/hello.py:1: DeprecationWarning: 
Pyarrow will become a required dependency of pandas in the next major release of pandas (pandas 3.0),
(to allow more performant data types, such as the Arrow string type, and better interoperability with other libraries)
but was not found to be installed on your system.
If this would cause problems for you,
please provide us feedback at [https://github.com/pandas-dev/pandas/issues/54466](https://github.com/pandas-dev/pandas/issues/54466)
        
  import sys, pandas
Final Dockerfile:

Dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.0
COPY hello.py .
CMD ["python", "hello.py"]
```
# Part 2. Reproducibility judgment

## Question 2.1 — Why pin?

If you simply write RUN pip install pandas, Docker will fetch the latest available version of the library at the exact moment the image is built. While it works perfectly today, if a collaborator tries to build the image a year from now, pip might install a newer version of pandas (e.g., 3.0) that includes breaking changes or deprecated functions. This destroys reproducibility, as the exact same hello.py script might suddenly crash or produce completely different analytical results on their machine.

## Question 2.2 — Recipe or cake?

Sending the Dockerfile and source code (the recipe) is better for reproducible research because it provides full transparency into how the computational environment is constructed. A pre-built image (the cake) acts as a "black box" binary; while it runs identically, a peer reviewer cannot easily audit the exact underlying system libraries or package dependencies used to generate the results. The Dockerfile serves as plain-text, human-readable documentation of your environment, allowing others not only to verify your methods but also to easily modify and extend your research.