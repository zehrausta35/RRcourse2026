# Docker Assignment

## Task 1.1

```bash
$ cat > Dockerfile << 'EOF'
FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir numpy==1.26.4

COPY hello.py .

CMD ["python", "hello.py"]
EOF

$ docker build -t hello-docker .
[+] Building 0.9s (11/11) FINISHED                         docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 282B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         0.6s
 => [auth] library/python:pull token for registry-1.docker.io              0.0s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/5] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => CACHED [2/5] RUN apt-get update && apt-get install -y     gcc     g++  0.0s
 => CACHED [3/5] WORKDIR /app                                              0.0s
 => CACHED [4/5] RUN pip install --no-cache-dir numpy==1.26.4              0.0s
 => [5/5] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.2s
 => => naming to docker.io/library/hello-docker:latest                     0.0s

$ docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

## Task 1.2 — Failed run

```bash
$ cat > hello.py << 'EOF'
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
EOF

$ docker build -t hello-docker .
[+] Building 0.5s (10/10) FINISHED                         docker:desktop-linux
 => CACHED [4/5] RUN pip install --no-cache-dir numpy==1.26.4              0.0s
 => [5/5] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'
```

## Task 1.2 — Fixed run

```bash
$ cat > Dockerfile << 'EOF'
FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir numpy==1.26.4 pandas==2.2.3

COPY hello.py .

CMD ["python", "hello.py"]
EOF

$ docker build -t hello-docker .
[+] Building 0.8s (10/10) FINISHED                         docker:desktop-linux
 => CACHED [2/5] RUN apt-get update && apt-get install -y     gcc     g++  0.0s
 => CACHED [3/5] WORKDIR /app                                              0.0s
 => CACHED [4/5] RUN pip install --no-cache-dir numpy==1.26.4 pandas==2.2  0.0s
 => [5/5] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.5s
 => => naming to docker.io/library/hello-docker:latest                     0.0s

$ docker run --rm hello-docker
Python 3.9, pandas 2.2.3
```

## Final Dockerfile

```
FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir numpy==1.26.4 pandas==2.2.3

COPY hello.py .

CMD ["python", "hello.py"]
```

## Question 2.1 — Why pin?

Pinning a specific version ensures the same library is installed every time the image is built. Without pinning, `pip install pandas` fetches the latest version, which may change over time. A future version could break existing code, alter output, or behave differently. This means the same Dockerfile could produce different results depending on when it is built, which undermines reproducibility.

## Question 2.2 — Recipe or cake?

Sending the Dockerfile and source files is better for reproducible research. Unlike a pre-built image, the Dockerfile is human-readable and can be inspected, audited, and understood step by step. This transparency allows others to verify exactly what environment was created and why — which is a core requirement of reproducible research, not just convenience.