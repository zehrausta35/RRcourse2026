## Task 1.1

\`\`\`bash\
\$ docker build -t hello-docker .\
[+] Building 8.4s (8/8) FINISHED docker:desktop-linux\
=\> [internal] load build definition from Dockerfile 0.0s\
=\> =\> transferring dockerfile: 114B 0.0s\
=\> [internal] load metadata for docker.io/library/python:3.9-slim 1.9s\
=\> [internal] load .dockerignore 0.0s\
=\> =\> transferring context: 2B 0.0s\
=\> [1/3] FROM docker.io/library/python:[3.9-slim\@sha256](mailto:3.9-slim@sha256){.email}:2d97f6910b16bd338 6.1s\
=\> =\> resolve docker.io/library/python:[3.9-slim\@sha256](mailto:3.9-slim@sha256){.email}:2d97f6910b16bd338 0.0s\
=\> =\> sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad2 251B / 251B 0.5s\
=\> =\> sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3 1.27MB / 1.27MB 1.6s\
=\> =\> sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce 13.83MB / 13.83MB 1.7s\
=\> =\> sha256:a16e551192670581ec8359c70ab9eebf8f2af5468 30.14MB / 30.14MB 5.1s\
=\> =\> extracting sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3 0.6s\
=\> =\> extracting sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3f3691 0.1s\
=\> =\> extracting sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0a 0.3s\
=\> =\> extracting sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad28 0.0s\
=\> [internal] load build context 0.0s\
=\> =\> transferring context: 29B 0.0s\
=\> [2/3] WORKDIR /app 0.2s\
=\> [3/3] COPY hello.py . 0.0s\
=\> exporting to image 0.1s\
=\> =\> exporting layers 0.0s\
=\> =\> exporting manifest sha256:d78e08f1f18db5d35064a5a89510d9d63484c810 0.0s\
=\> =\> exporting config sha256:f839ae4305eb8665fd67d72928150b460731da7ab2 0.0s\
=\> =\> exporting attestation manifest sha256:ae2c8da8b9d32173458461666632 0.0s\
=\> =\> exporting manifest list sha256:6936e62437a5b2ecec2769510f91521c25b 0.0s\
=\> =\> naming to docker.io/library/hello-docker:latest 0.0s\
=\> =\> unpacking to docker.io/library/hello-docker:latest 0.0s\
\
\$ docker run --rm hello-docker\
Hello from Python 3.9 inside a container!}

## Task 1.2 — failed run

$ docker build -t hello-docker .
[+] Building 1.3s (9/9) FINISHED                           docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 114B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         1.2s
 => [auth] library/python:pull token for registry-1.docker.io              0.0s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 149B                                          0.0s
 => CACHED [2/3] WORKDIR /app                                              0.0s
 => [3/3] COPY hello.py .                                                  0.0s
 => exporting to image                                                     0.1s
 => => exporting layers                                                    0.0s
 => => exporting manifest sha256:a664fd276380c34956f756ec975527da88b19611  0.0s
 => => exporting config sha256:ae2ffd2cb25a32a102f5f8b8afa4c5ee8e5189e94d  0.0s
 => => exporting attestation manifest sha256:c02bb357352a9d3bc91a02ae2985  0.0s
 => => exporting manifest list sha256:ad088feaaec72800c7ec11a8680b34d79d2  0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s
 => => unpacking to docker.io/library/hello-docker:latest                  0.0s

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

## Task 1.2 — Fixed run

$ docker build -t hello-docker .
[+] Building 19.3s (9/9) FINISHED                          docker:desktop-linux
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 143B                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim         0.9s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338  0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 29B                                           0.0s
 => CACHED [2/4] WORKDIR /app                                              0.0s
 => [3/4] RUN pip install pandas==2.2.2                                   11.4s
 => [4/4] COPY hello.py .                                                  0.0s
 => exporting to image                                                     6.8s
 => => exporting layers                                                    5.7s
 => => exporting manifest sha256:2f8dc551928256f1f6c11e3bb5469b139d3f1865  0.0s
 => => exporting config sha256:4c73bb3b3734f23a326100b9e9e1b8a69078268d43  0.0s
 => => exporting attestation manifest sha256:a0ceb6ba57bd17157e62a832c4f9  0.0s
 => => exporting manifest list sha256:a3d5881c78f2211b3dfbbbf7bd567f79e34  0.0s
 => => naming to docker.io/library/hello-docker:latest                     0.0s
 => => unpacking to docker.io/library/hello-docker:latest                  1.1s

$ docker run --rm hello-docker
Python 3.9, pandas 2.2.2

## Final Dockerfile

FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]

## Question 2.1 — Why pin?

Pinning a specific version of pandas is important because otherwise the Dockerfile may install a different version in the future than it installs today. If a new pandas release changes behavior, removes older functionality, or introduces different dependencies, the same code may stop working or produce different results. That means another person rebuilding the image later might not get the same environment that I used. Version pinning makes the setup stable and reproducible over time.

## Question 2.2 — Recipe or cake?

For reproducible research, it is better to share the Dockerfile together with the source files, not only the built image. The Dockerfile makes the environment creation process transparent, because another researcher can see exactly which base image, package versions, and steps were used. This allows others to inspect, rebuild, verify, and modify the setup if needed. A built image is useful as a snapshot, but by itself it hides how that snapshot was created.
