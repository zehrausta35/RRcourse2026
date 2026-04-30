PART 1:

Task 1.1:



Windows PowerShell

Copyright (C) Microsoft Corporation. All rights reserved.



Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows



PS C:\\Users\\zosia> cd C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> ls





&#x20;   Directory: C:\\Users\\zosia\\ReproducibleResearch\\repositories

&#x20;   \\RRcourse2026\\Week10-Docker\\hello-docker





Mode                 LastWriteTime         Length Name

\----                 -------------         ------ ----

\-a----        30.04.2026     19:33            112 Dockerfile

\-a----        30.04.2026     19:33            116 hello.py





PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type Dockerfiletype Dockerfile

Get-Content : A positional parameter cannot be found that accep

ts argument 'Dockerfile'.

At line:1 char:1

\+ type Dockerfiletype Dockerfile

\+ \~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~\~

&#x20;   + CategoryInfo          : InvalidArgument: (:) \[Get-Conten

&#x20;  t], ParameterBindingException

&#x20;   + FullyQualifiedErrorId : PositionalParameterNotFound,Micr

&#x20;  osoft.PowerShell.Commands.GetContentCommand



PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type Dockerfile

FROM python:3.11-slim

WORKDIR /app

RUN pip install numpy==1.26.4

COPY hello.py .

CMD \["python", "hello.py"]

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type hello.py

import sys, numpy

print(f"Python {sys.version\_info.major}.{sys.version\_info.minor}, NumPy {numpy.\_\_version\_\_}")

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> @'

>> import sys

>> print(f"Hello from Python {sys.version\_info.major}.{sys.version\_info.minor} inside a container!")

>> '@ | Out-File -FilePath hello.py -Encoding utf8

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type hello.py

import sys

print(f"Hello from Python {sys.version\_info.major}.{sys.version\_info.minor} inside a container!")

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> python hello.py

Hello from Python 3.14 inside a container!

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> @'

>> FROM python:3.9-slim

>> WORKDIR /app

>> COPY hello.py .

>> CMD \["python", "hello.py"]

>> '@ | Out-File -FilePath Dockerfile -Encoding utf8

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type Dockerfile

FROM python:3.9-slim

WORKDIR /app

COPY hello.py .

CMD \["python", "hello.py"]

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> docker build -t hello-docker .

\[+] Building 130.9s (8/8) FINISHED         docker:desktop-linux

&#x20;=> \[internal] load build definition from Dockerfile       0.0s

&#x20;=> => transferring dockerfile: 118B                       0.0s

&#x20;=> \[internal] load metadata for docker.io/library/pytho  20.3s

&#x20;=> \[internal] load .dockerignore                          0.0s

&#x20;=> => transferring context: 2B                            0.0s

&#x20;=> \[1/3] FROM docker.io/library/python:3.9-slim@sha256  109.4s

&#x20;=> => resolve docker.io/library/python:3.9-slim@sha256:2  0.1s

&#x20;=> => sha256:ea56f685404adf81680322f152d2cfe 251B / 251B  1.3s

&#x20;=> => sha256:fc74430849022d13b0d44b89 13.88MB / 13.88MB  96.8s

&#x20;=> => sha256:b3ec39b36ae8c03a3e09854de4 1.29MB / 1.29MB  17.8s

&#x20;=> => sha256:38513bd7256313495cdd83b 29.78MB / 29.78MB  106.7s

&#x20;=> => extracting sha256:38513bd7256313495cdd83b3b0915a63  1.4s

&#x20;=> => extracting sha256:b3ec39b36ae8c03a3e09854de4ec4aa0  0.2s

&#x20;=> => extracting sha256:fc74430849022d13b0d44b8969a953f8  0.9s

&#x20;=> => extracting sha256:ea56f685404adf81680322f152d2cfec  0.0s

&#x20;=> \[internal] load build context                          0.0s

&#x20;=> => transferring context: 148B                          0.0s

&#x20;=> \[2/3] WORKDIR /app                                     0.3s

&#x20;=> \[3/3] COPY hello.py .                                  0.1s

&#x20;=> exporting to image                                     0.5s

&#x20;=> => exporting layers                                    0.2s

&#x20;=> => exporting manifest sha256:aebc1123c39d83ef0fb6d93e  0.0s

&#x20;=> => exporting config sha256:bb21bd75d056d53c8d0c8b621b  0.0s

&#x20;=> => exporting attestation manifest sha256:f25f88a3348b  0.0s

&#x20;=> => exporting manifest list sha256:8dc2e02e2c5a60ca2aa  0.0s

&#x20;=> => naming to docker.io/library/hello-docker:latest     0.0s

&#x20;=> => unpacking to docker.io/library/hello-docker:latest  0.1s

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> docker run --rm hello-docker

Hello from Python 3.9 inside a container!





Task 1.2:



PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> @'

>> import sys, pandas

>> print(f"Python {sys.version\_info.major}.{sys.version\_info.minor}, pandas {pandas.\_\_version\_\_}")

>> '@ | Out-File -FilePath hello.py -Encoding utf8

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type hello.py

import sys, pandas

print(f"Python {sys.version\_info.major}.{sys.version\_info.minor}, pandas {pandas.\_\_version\_\_}")

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> @'

>> FROM python:3.9-slim

>> WORKDIR /app

>> COPY hello.py .

>> CMD \["python", "hello.py"]

>> '@ | Out-File -FilePath Dockerfile -Encoding utf8

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> docker build -t hello-docker .

\[+] Building 2.9s (8/8) FINISHED           docker:desktop-linux

&#x20;=> \[internal] load build definition from Dockerfile       0.0s

&#x20;=> => transferring dockerfile: 118B                       0.0s

&#x20;=> \[internal] load metadata for docker.io/library/python  1.9s

&#x20;=> \[internal] load .dockerignore                          0.0s

&#x20;=> => transferring context: 2B                            0.0s

&#x20;=> \[1/3] FROM docker.io/library/python:3.9-slim@sha256:2  0.1s

&#x20;=> => resolve docker.io/library/python:3.9-slim@sha256:2  0.1s

&#x20;=> \[internal] load build context                          0.0s

&#x20;=> => transferring context: 154B                          0.0s

&#x20;=> CACHED \[2/3] WORKDIR /app                              0.0s

&#x20;=> \[3/3] COPY hello.py .                                  0.1s

&#x20;=> exporting to image                                     0.6s

&#x20;=> => exporting layers                                    0.2s

&#x20;=> => exporting manifest sha256:5bc2e52d51662f85b65e1b59  0.0s

&#x20;=> => exporting config sha256:543812e7457134f7fecaac515c  0.0s

&#x20;=> => exporting attestation manifest sha256:07242efa8c45  0.1s

&#x20;=> => exporting manifest list sha256:5a8ff682aaa2db644c6  0.0s

&#x20;=> => naming to docker.io/library/hello-docker:latest     0.0s

&#x20;=> => unpacking to docker.io/library/hello-docker:latest  0.1s

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> docker run --rm hello-docker

Traceback (most recent call last):

&#x20; File "/app/hello.py", line 1, in <module>

&#x20;   ﻿import sys, pandas

ModuleNotFoundError: No module named 'pandas'



What's next:

&#x20;   Debug this container error with Gordon → docker ai "help me fix this container error"

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> @'

>> FROM python:3.9-slim

>> WORKDIR /app

>> RUN pip install pandas==2.2.2

>> COPY hello.py .

>> CMD \["python", "hello.py"]

>> '@ | Out-File -FilePath Dockerfile -Encoding utf8

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> type Dockerfile

FROM python:3.9-slim

WORKDIR /app

RUN pip install pandas==2.2.2

COPY hello.py .

CMD \["python", "hello.py"]

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> docker build -t hello-docker .

\[+] Building 48.8s (9/9) FINISHED          docker:desktop-linux

&#x20;=> \[internal] load build definition from Dockerfile       0.0s

&#x20;=> => transferring dockerfile: 148B                       0.0s

&#x20;=> \[internal] load metadata for docker.io/library/python  1.0s

&#x20;=> \[internal] load .dockerignore                          0.0s

&#x20;=> => transferring context: 2B                            0.0s

&#x20;=> \[1/4] FROM docker.io/library/python:3.9-slim@sha256:2  0.0s

&#x20;=> => resolve docker.io/library/python:3.9-slim@sha256:2  0.0s

&#x20;=> \[internal] load build context                          0.0s

&#x20;=> => transferring context: 29B                           0.0s

&#x20;=> CACHED \[2/4] WORKDIR /app                              0.0s

&#x20;=> \[3/4] RUN pip install pandas==2.2.2                   32.0s

&#x20;=> \[4/4] COPY hello.py .                                  0.1s

&#x20;=> exporting to image                                    15.4s

&#x20;=> => exporting layers                                   11.8s

&#x20;=> => exporting manifest sha256:b437d1cd05e884843044839a  0.0s

&#x20;=> => exporting config sha256:55d42a977fdbe723f4fce6bc33  0.0s

&#x20;=> => exporting attestation manifest sha256:9b24cc9ed369  0.0s

&#x20;=> => exporting manifest list sha256:9f671fa90d6a99b05d0  0.0s

&#x20;=> => naming to docker.io/library/hello-docker:latest     0.0s

&#x20;=> => unpacking to docker.io/library/hello-docker:latest  3.3s

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker> docker run --rm hello-docker

Python 3.9, pandas 2.2.2

PS C:\\Users\\zosia\\ReproducibleResearch\\repositories\\RRcourse2026\\Week10-Docker\\hello-docker>





3\. Final Dockerfile



FROM python:3.9-slim

WORKDIR /app

RUN pip install pandas==2.2.2

COPY hello.py .

CMD \["python", "hello.py"]



PART 2:
Question 2.1:

If I write RUN pip install pandas without specifying a version, the Dockerfile might install a different version of pandas in the future. That means the exact same Dockerfile could create a different environment later, even if my own code stays unchanged. A newer pandas version could behave differently, introduce incompatibilities, or remove something my script depends on. By pinning a specific version, I make sure the environment can be rebuilt in the same way later, which is important for reproducibility.

Question 2.2:



For reproducible research, I think it is usually better to share the Dockerfile together with the source files. The Dockerfile clearly shows how the environment was created, so someone else can inspect it, understand it, and rebuild it themselves. That is important in research, because reproducibility is not just about getting the code to run once, but also about making the setup transparent and understandable. A built image can be useful, but the Dockerfile gives a clearer record of how that image was made.



