# Docker Assignment

Name: Kuo Zhang

## Task 1.1 — Change the Python version

I edited the `Dockerfile` to use Python 3.9 instead of Python 3.11. Then I rebuilt the image and ran the container.

```bash
$ cat > hello.py << 'EOF'
import sys
print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
EOF

$ cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
EOF

$ docker build --progress=plain -t hello-docker .
#0 building with "desktop-linux" instance using docker driver
#1 [internal] load build definition from Dockerfile
#1 DONE 0.0s
#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE
#3 [internal] load .dockerignore
#3 DONE 0.0s
#4 [internal] load build context
#4 DONE 0.0s
#5 [1/3] FROM docker.io/library/python:3.9-slim
#5 DONE
#6 [2/3] WORKDIR /app
#6 DONE
#7 [3/3] COPY hello.py .
#7 DONE
#8 exporting to image
#8 naming to docker.io/library/hello-docker:latest done
#8 DONE

$ docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

## Task 1.2 — Break and fix the Dockerfile

First, I changed `hello.py` so that it imports `pandas`.

```bash
$ cat > hello.py << 'EOF'
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
EOF

$ cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
EOF

$ docker build --progress=plain -t hello-docker .
#0 building with "desktop-linux" instance using docker driver
#1 [internal] load build definition from Dockerfile
#1 DONE 0.0s
#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE
#3 [internal] load .dockerignore
#3 DONE 0.0s
#4 [internal] load build context
#4 DONE 0.0s
#5 [1/3] FROM docker.io/library/python:3.9-slim
#5 DONE
#6 [2/3] WORKDIR /app
#6 CACHED
#7 [3/3] COPY hello.py .
#7 DONE
#8 exporting to image
#8 naming to docker.io/library/hello-docker:latest done
#8 DONE

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'
```

The run failed because the container did not have `pandas` installed. I fixed this by adding a `RUN` line to the `Dockerfile` and pinning a specific version of pandas.

```bash
$ cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
RUN pip install --no-cache-dir pandas==2.2.3
COPY hello.py .
CMD ["python", "hello.py"]
EOF

$ docker build --progress=plain -t hello-docker .
#0 building with "desktop-linux" instance using docker driver
#1 [internal] load build definition from Dockerfile
#1 DONE 0.0s
#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE
#3 [internal] load .dockerignore
#3 DONE 0.0s
#4 [internal] load build context
#4 DONE 0.0s
#5 [1/4] FROM docker.io/library/python:3.9-slim
#5 DONE
#6 [2/4] WORKDIR /app
#6 CACHED
#7 [3/4] RUN pip install --no-cache-dir pandas==2.2.3
#7 Successfully installed numpy-2.0.2 pandas-2.2.3 python-dateutil-2.9.0.post0 pytz-2026.1.post1 six-1.17.0 tzdata-2026.2
#7 DONE
#8 [4/4] COPY hello.py .
#8 DONE
#9 exporting to image
#9 naming to docker.io/library/hello-docker:latest done
#9 DONE

$ docker run --rm hello-docker
Python 3.9, pandas 2.2.3
```

Final `Dockerfile`:

```dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install --no-cache-dir pandas==2.2.3
COPY hello.py .
CMD ["python", "hello.py"]
```

## Question 2.1 — Why pin?

Using `pip install pandas` without a version is a reproducibility problem because it installs whichever pandas version is current at build time. This means the same Dockerfile may produce a different environment today, next month, or next year. A newer pandas version could change behavior, install different dependencies, or even break code that used to work. Pinning the version with `pandas==2.2.3` makes the environment more stable and makes the result easier for another person to reproduce.

## Question 2.2 — Recipe or cake?

For reproducible research, sending the `Dockerfile` and `hello.py` is usually better than only sending the built image. The Dockerfile is the recipe: it shows exactly how the environment is constructed, which base image is used, and which packages are installed. A built image can be faster to run, but it is less transparent because the recipient may not easily see how it was created. The best reproducibility practice is to share the recipe and pin important versions, so others can rebuild and inspect the environment themselves.
