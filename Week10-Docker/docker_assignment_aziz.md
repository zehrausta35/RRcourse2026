# Task 1.1

(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % docker run --rm hello-docker
Hello from Python 3.11 inside a container!
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
EOF
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % cat Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % docker build -t hello-docker .
[+] Building 10.9s (8/8) FINISHED                          docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 114B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         1.9s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  8.6s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => => sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad2 251B / 251B  0.4s
 => => sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce 13.83MB / 13.83MB  2.0s
 => => sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3 1.27MB / 1.27MB  1.4s
 => => sha256:a16e551192670581ec8359c70ab9eebf8f2af5468 30.14MB / 30.14MB  7.4s
 => => extracting sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3  0.7s
 => => extracting sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3f3691  0.1s
 => => extracting sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0a  0.3s
 => => extracting sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad28  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 29B                                           0.0s
 => [2/3] WORKDIR /app                                                     0.2s
 => [3/3] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.1s
 => => exporting layers                                                    0.0s
 => => exporting manifest sha256:40cdd129efa7b58a8a8a488da486c103d7fd589d  0.0s
 => => exporting config sha256:39bd43812953a5eb7fb23a4c6b902bb67000c4c8ba  0.0s
 => => exporting attestation manifest sha256:bc3df3d4ae2e8c1db9960834d3f9  0.0s
 => => exporting manifest list sha256:cd995e57addca3121ad6906770f946831a8  0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s
 => => unpacking to docker.io/library/hello-docker:latest                  0.0s
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % docker run --rm hello-docker
Hello from Python 3.9 inside a container!


# Task 1.2 — Failed Run

(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % cat > hello.py << 'EOF' 
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
EOF
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % docker build -t hello-docker .
docker run --rm hello-docker
[+] Building 1.7s (9/9) FINISHED                              docker:desktop-linux
 => [internal] load build definition from Dockerfile                          0.0s
 => => transferring dockerfile: 114B                                          0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim            1.5s
 => [auth] library/python:pull token for registry-1.docker.io                 0.0s
 => [internal] load .dockerignore                                             0.0s
 => => transferring context: 2B                                               0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d30  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d30  0.0s
 => [internal] load build context                                             0.0s
 => => transferring context: 150B                                             0.0s
 => CACHED [2/3] WORKDIR /app                                                 0.0s
 => [3/3] COPY hello.py .                                                     0.0s
 => exporting to image                                                        0.1s
 => => exporting layers                                                       0.0s
 => => exporting manifest sha256:6ba55bb674142ed87c4e7cd4cb0c5ebf07cf10ca327  0.0s
 => => exporting config sha256:70fb4311ef55d7e37c40adca436a1172ed5072bcb3a0c  0.0s
 => => exporting attestation manifest sha256:77a7177a65c0655898472b822fd7cdb  0.0s
 => => exporting manifest list sha256:73a0971ee4a3c92cf594255136d1eacd2e2f8f  0.0s
 => => naming to docker.io/library/hello-docker:latest                        0.0s
 => => unpacking to docker.io/library/hello-docker:latest                     0.0s
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % 

# Task 1.2 — Successful Run After Fix

(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]
EOF
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % cat Dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % docker build -t hello-docker .
[+] Building 27.0s (9/9) FINISHED                             docker:desktop-linux
 => [internal] load build definition from Dockerfile                          0.0s
 => => transferring dockerfile: 144B                                          0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim            0.7s
 => [internal] load .dockerignore                                             0.0s
 => => transferring context: 2B                                               0.0s
 => [internal] load build context                                             0.0s
 => => transferring context: 29B                                              0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d30  0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d30  0.0s
 => CACHED [2/4] WORKDIR /app                                                 0.0s
 => [3/4] RUN pip install pandas==2.2.2                                      18.5s
 => [4/4] COPY hello.py .                                                     0.1s 
 => exporting to image                                                        7.5s 
 => => exporting layers                                                       6.0s 
 => => exporting manifest sha256:e75ccccda78c5f3b984dce53cc3b220a91420ee4c82  0.0s 
 => => exporting config sha256:5629d5045937927a5663c2e9ab19eae6bd72947dec053  0.0s 
 => => exporting attestation manifest sha256:301ad8370df5134a81df42fe428842a  0.0s 
 => => exporting manifest list sha256:a88ccdd36c2924422487529668fce2b57182d0  0.0s
 => => naming to docker.io/library/hello-docker:latest                        0.0s
 => => unpacking to docker.io/library/hello-docker:latest                     1.4s
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % docker run --rm hello-docker
Python 3.9, pandas 2.2.2
(base) ashutoshverma@Ashutoshs-MacBook-Air-2 hello-docker % 

# Question 2.1 — Why pin?

if I install pandas without specifying a version, Docker will install the latest version available at 
build time. This means that rebuilding the image in the future could install a different version of 
pandas, potentially introducing breaking changes or different behavior. Even if the code still runs, 
the output could change, making results inconsistent over time. Pinning ensures that the exact same 
version is always installed, guaranteeing reproducibility. 

# Question 2.2 — Recipe or cake?

Sending the Dockerfile and source code is better for reproducible research because it makes the 
environment transparent and rebuildable. A pre-built image is like a black box — it runs, but we 
cannot easily inspect how it was created. The Dockerfile documents every step of the environment setup 
and can be version-controlled. This makes the research process auditable and reproducible in the long 
term.