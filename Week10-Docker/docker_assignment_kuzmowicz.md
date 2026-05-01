# RR Docker Assignment 2026
### Cezary Kuźmowicz, 473169

## Part 1. Docker Mechanics

### Task 1.1 — Change the current Python version
```text
(base) czarek@Czaro-2 hello-docker % docker build -t hello-docker . 
[+] Building 1.5s (9/9) FINISHED                       docker:desktop-linux
 => [internal] load build definition from Dockerfile                   0.0s
 => => transferring dockerfile: 114B                                   0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim     1.3s
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

(base) czarek@Czaro-2 hello-docker % docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

### Task 1.2 — Break and fix the Dockerfile

**Failed run:**

```text
(base) czarek@Czaro-2 hello-docker % docker build -t hello-docker . 
[+] Building 0.5s (8/8) FINISHED                       docker:desktop-linux
 => [internal] load build definition from Dockerfile                   0.0s
...
 => => naming to docker.io/library/hello-docker:latest                 0.0s
 => => unpacking to docker.io/library/hello-docker:latest              0.0s

(base) czarek@Czaro-2 hello-docker % docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'
```

**Successful run:**

```text
(base) czarek@Czaro-2 hello-docker % docker build -t hello-docker . 
[+] Building 27.5s (9/9) FINISHED                      docker:desktop-linux
 => [internal] load build definition from Dockerfile                   0.0s
...
 => [3/4] RUN pip install pandas==2.2.0                               21.7s
 => [4/4] COPY hello.py .                                              0.0s 
 => exporting to image                                                 4.7s 
...
 => => naming to docker.io/library/hello-docker:latest                 0.0s
 => => unpacking to docker.io/library/hello-docker:latest              0.9s

(base) czarek@Czaro-2 hello-docker % docker run --rm hello-docker
Python 3.9, pandas 2.2.0
/app/hello.py:1: DeprecationWarning: 
Pyarrow will become a required dependency of pandas in the next major release of pandas (pandas 3.0),
(to allow more performant data types, such as the Arrow string type, and better interoperability with other libraries)
but was not found to be installed on your system.
If this would cause problems for you,
please provide us feedback at [https://github.com/pandas-dev/pandas/issues/54466](https://github.com/pandas-dev/pandas/issues/54466)
        
  import sys, pandas
```

**Final Dockerfile:**

```dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.0
COPY hello.py .
CMD ["python", "hello.py"]
```

## Part 2. Reproducibility judgment

### Question 2.1 — Why pin?

If we just write `RUN pip install pandas`, Docker grabs the latest version available at that exact moment. It works fine today, but if someone builds the image next year, pip might install a completely new version with breaking changes. This ruins reproducibility because the exact same script might crash or give different results on their machine. Pinning the version stops this from happening.

### Question 2.2 — Recipe or cake?

Sharing the Dockerfile (the recipe) is better because it's completely transparent. An image (the cake) is basically a black box—you can run it, but you can't easily check what exact packages or OS versions are inside. The Dockerfile is just plain text, so anyone can read exactly how the environment was built step-by-step, verify our work, or tweak it for their own research.