# Docker Assignment

## Task 1.1

```
matsoikwan@Tsois-MacBook-Air hello-docker % cat > hello.py << 'EOF'
import sys
print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
EOF
matsoikwan@Tsois-MacBook-Air hello-docker % cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
EOF
matsoikwan@Tsois-MacBook-Air hello-docker % docker build -t hello-docker .
[+] Building 0.8s (8/8) FINISHED                           docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 114B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         0.7s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 144B                                          0.0s
 => CACHED [2/3] WORKDIR /app                                              0.0s
 => [3/3] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.1s
 => => exporting layers                                                    0.0s
 => => exporting manifest sha256:ebf9b356e99e46ca8045b7a9daed7cfa60d1d923  0.0s
 => => exporting config sha256:415247611e3fad954d3f75cfc10c3dcc4130112047  0.0s
 => => exporting attestation manifest sha256:7cf80e1360158f76abd6ae70bad9  0.0s
 => => exporting manifest list sha256:188ec76161784b1b977b6b308b5440f7d30  0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s
 => => unpacking to docker.io/library/hello-docker:latest                  0.0s
matsoikwan@Tsois-MacBook-Air hello-docker % docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

## Task 1.2

### Failed run

```
matsoikwan@Tsois-MacBook-Air hello-docker % cat > hello.py << 'EOF'
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
EOF
matsoikwan@Tsois-MacBook-Air hello-docker % docker build -t hello-docker .
[+] Building 0.8s (8/8) FINISHED                           docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 114B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         0.6s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 150B                                          0.0s
 => CACHED [2/3] WORKDIR /app                                              0.0s
 => [3/3] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.1s
 => => exporting layers                                                    0.0s
 => => exporting manifest sha256:77b8c019f66b38b4f3fa3bc7fed0ff114dee149a  0.0s
 => => exporting config sha256:a7d229304ebe22907d0e15589069d7ad478d25eead  0.0s
 => => exporting attestation manifest sha256:a4b4d992b36a11b2a6f0dadc64c7  0.0s
 => => exporting manifest list sha256:94b2d185f42efe11e6e4150e3986ac84ceb  0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s
 => => unpacking to docker.io/library/hello-docker:latest                  0.0s
matsoikwan@Tsois-MacBook-Air hello-docker % docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
```

### Successful run after fix

```
matsoikwan@Tsois-MacBook-Air hello-docker % cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.3
COPY hello.py .
CMD ["python", "hello.py"]
EOF
matsoikwan@Tsois-MacBook-Air hello-docker % docker build -t hello-docker .
[+] Building 20.5s (9/9) FINISHED                          docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 144B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         0.7s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 29B                                           0.0s
 => CACHED [2/4] WORKDIR /app                                              0.0s
 => [3/4] RUN pip install pandas==2.2.3                                   13.1s
 => [4/4] COPY hello.py .                                                  0.0s 
 => exporting to image                                                     6.6s 
 => => exporting layers                                                    5.6s 
 => => exporting manifest sha256:bcbc6c0980ba66902b10b503a3c301886c42fa35  0.0s 
 => => exporting config sha256:1e7c9a01be12e2af3262f1db20c54f8950f145d1b1  0.0s 
 => => exporting attestation manifest sha256:94c173cb870ee4667db1a5903b0f  0.0s 
 => => exporting manifest list sha256:b1a96247a483e6370f4feb6db6ad72c4cd8  0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s
 => => unpacking to docker.io/library/hello-docker:latest                  1.0s
matsoikwan@Tsois-MacBook-Air hello-docker % docker run --rm hello-docker
Python 3.9, pandas 2.2.3
```

### Final Dockerfile

```
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.3
COPY hello.py .
CMD ["python", "hello.py"]
```

## Question 2.1

Pinning a package version means that everyone builds the image with the same version of that package. If I wrote only "RUN pip install pandas"", Docker would install whatever the latest pandas version is at the time of building. That might work today, but a future pandas release could change behavior, remove features, or introduce incompatibilities with my code. Therefore, the same Dockerfile could produce different results depending on when it is built which is a reproducibility problem.

## Question 2.2

For reproducible research, it is better to share the Dockerfile and "hello.py" because they show exactly how the environment and result were created. A built image can reproduce the result but it hides the recipe and makes it harder to inspect, review, or modify the environment. The Dockerfile is plain text so it can be version-controlled and compared over time, which makes the computational environment more transparent and auditable.