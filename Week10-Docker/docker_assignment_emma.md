# Docker Assignment - emma-2304

## Task 1.1 — Change the Python version

```bash
$ docker build -t hello-docker .
$ docker run --rm hello-docker
Hello from Python 3.9 inside a container!
Task 1.2 — Break and fix the Dockerfile
1. Failed run (pandas not installed):
Bash$ cat > hello.py << 'EOF'
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
EOF

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'
2. Successful run (after fix):
Bash$ docker build -t hello-docker .
$ docker run --rm hello-docker
Python 3.9, pandas 2.2.3
Final Dockerfile:
dockerfileFROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir numpy==1.26.4 pandas==2.2.3

COPY hello.py .

CMD ["python", "hello.py"]
Question 2.1 — Why pin?
Pinning a specific version of pandas (e.g. pandas==2.2.3) is very important for reproducibility.
If we only write RUN pip install pandas without a version number, pip will install the latest version available at the time the image is built.
This means that if someone builds the Docker image in the future, they might get a different version of pandas that has API changes or bug fixes.
As a result, the same code may produce different results or even break.
Pinning the version guarantees that everyone gets the exact same environment and the same results.
Question 2.2 — Recipe or cake?
For reproducible research, sharing the Dockerfile (the recipe) is much better than sharing only the built Docker image (the cake).
The Dockerfile is a readable text file that explicitly shows all the steps, base image, and package versions used.
This allows others to understand, verify, and modify the environment easily.
It also works well with Git for version control.
Sharing only the image is less transparent and harder for others to inspect what is actually inside the environment.
