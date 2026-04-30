## Task 1.1 - Change the Python version
``` 

(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> @'
>> import sys
>> print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
>> '@ | Out-File -FilePath hello.py -Encoding utf8
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> type hello.py
import sys
print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> python hello.py
Hello from Python 3.12 inside a container!
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> @'
>> FROM python:3.9-slim
>> WORKDIR /app
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
[+] Building 2.3s (9/9) FINISHED                                                                                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                    0.0s
 => => transferring dockerfile: 118B                                                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                      1.1s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                       0.0s
 => => transferring context: 2B                                                                                                                         0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                0.1s
 => [internal] load build context                                                                                                                       0.0s
 => => transferring context: 148B                                                                                                                       0.0s
 => CACHED [2/3] WORKDIR /app                                                                                                                           0.0s
 => [3/3] COPY hello.py .                                                                                                                               0.1s
 => exporting to image                                                                                                                                  0.5s
 => => exporting layers                                                                                                                                 0.1s
 => => exporting manifest sha256:5f279502b049708247f3e77b261767c6f83312b0eb7b16ff1721d7d663fe3cb9                                                       0.0s
 => => exporting config sha256:488908d21b51d1bbb61cde0066a3af6ec0579e8544d96cd83d2d7fa32581b3a1                                                         0.0s
 => => exporting attestation manifest sha256:c89290bfb4aeb41d30f3983eacfff1eaac0da1503b7d72146ebc6205233300c4                                           0.1s
 => => exporting manifest list sha256:628358780bc2b883830c1cee6045372b407c350100d5fd487403bf6e1d984e94                                                  0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                                  0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                               0.1s
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> docker run --rm hello-docker
Hello from Python 3.9 inside a container!

```

## Task 1.2 - Break and fix the Dockerfile
``` 
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> @'
>> import sys, pandas
>> print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
>> '@ | Out-File -FilePath hello.py -Encoding utf8
>>
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
[+] Building 2.9s (9/9) FINISHED                                                                                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                    0.0s
 => => transferring dockerfile: 118B                                                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                      1.7s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                       0.0s
 => => transferring context: 2B                                                                                                                         0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                0.1s
 => [internal] load build context                                                                                                                       0.0s
 => => transferring context: 154B                                                                                                                       0.0s
 => CACHED [2/3] WORKDIR /app                                                                                                                           0.0s
 => [3/3] COPY hello.py .                                                                                                                               0.1s
 => exporting to image                                                                                                                                  0.5s
 => => exporting layers                                                                                                                                 0.1s
 => => exporting manifest sha256:91e3b9b242f0a159d32ddfa0d4c88b0918dd2e22335aaec9eacfaf55e8aa801b                                                       0.0s
 => => exporting config sha256:92cdbe4c6401dc7954188d5b88281a154ef8541ddef6701b7b664b6f0c814153                                                         0.0s
 => => exporting attestation manifest sha256:699d25cf5cc84f5fd231252df44b300be0b9927585b0b2f0b0e55c4908ea363c                                           0.1s
 => => exporting manifest list sha256:a7f1164817781e4a677634bf73610c09451db625c4de60148d2508df3770f550                                                  0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                                  0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                               0.1s
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    ﻿import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"

```
## Fixing the error
``` 
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> @'
>> FROM python:3.12-slim
>> WORKDIR /app
>> RUN pip install pandas==2.2.3
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
[+] Building 59.8s (10/10) FINISHED                                                                                                     docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                    0.0s
 => => transferring dockerfile: 149B                                                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.12-slim                                                                                     1.1s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                       0.0s
 => => transferring context: 2B                                                                                                                         0.0s
 => [1/4] FROM docker.io/library/python:3.12-slim@sha256:46cb7cc2877e60fbd5e21a9ae6115c30ace7a077b9f8772da879e4590c18c2e3                               0.1s
 => => resolve docker.io/library/python:3.12-slim@sha256:46cb7cc2877e60fbd5e21a9ae6115c30ace7a077b9f8772da879e4590c18c2e3                               0.1s
 => [internal] load build context                                                                                                                       0.0s
 => => transferring context: 29B                                                                                                                        0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                                           0.0s
 => [3/4] RUN pip install pandas==2.2.3                                                                                                                32.2s
 => [4/4] COPY hello.py .                                                                                                                               0.2s
 => exporting to image                                                                                                                                 26.4s
 => => exporting layers                                                                                                                                18.0s
 => => exporting manifest sha256:ee01c8311441edf4778fd7bd909ffc3897f35302769d12a9e2c81abe30875fdd                                                       0.0s
 => => exporting config sha256:40253f8b58b288b6448f81d232dfa52030727023db09f75428b2c15c77aea77b                                                         0.0s
 => => exporting attestation manifest sha256:47a8d95ff4fb43a8020af23f37fac6b97ca6e9333ab1a6905bd15733843dbbc6                                           0.1s
 => => exporting manifest list sha256:bf22a85735a5804f055a8a6cf7c7ac84025ceed4760715d6fe2c37e03d941e63                                                  0.1s
 => => naming to docker.io/library/hello-docker:latest                                                                                                  0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                               8.1s
(base) PS C:\Users\Surface 4\OneDrive\Documents\RR_1\cloned_RR_class\RRcourse2026\Week10-Docker\hello-docker> docker run --rm hello-docker
Python 3.12, pandas 2.2.3

```