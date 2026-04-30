### Assignment lesson n° 10 - Emanuele Bellezza - K-18722

## Task 1.1

```powershell
Python 3.11, NumPy 1.26.4
PS C:\Users\emanu\hello-docker> @'
>> FROM python:3.9
>> WORKDIR /app
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
PS C:\Users\emanu\hello-docker> docker build -t hello-docker .
[+] Building 381.1s (9/9) FINISHED     docker:desktop-linux
 => [internal] load build definition from Dockerfile   0.0s
 => => transferring dockerfile: 113B                   0.0s
 => [internal] load metadata for docker.io/library/py  1.9s
 => [auth] library/python:pull token for registry-1.d  0.0s
 => [internal] load .dockerignore                      0.0s
 => => transferring context: 2B                        0.0s
 => [internal] load build context                      0.0s
 => => transferring context: 29B                       0.0s
 => [1/3] FROM docker.io/library/python:3.9@sha256:  378.6s
 => => resolve docker.io/library/python:3.9@sha256:da  0.0s
 => => sha256:91c91c91f1d23f4edf4280a8fe9 250B / 250B  0.3s
 => => sha256:c9723aa529b03c40e66 20.37MB / 20.37MB  128.4s
 => => sha256:081ccf923272c30c6072c6 6.10MB / 6.10MB  12.9s
 => => sha256:79d5bd8a8d262418b 235.93MB / 235.93MB  371.9s
 => => sha256:26dfe2fac1c486e9aaf 67.78MB / 67.78MB  207.1s
 => => sha256:89d573bf42b377ce6a5 25.62MB / 25.62MB  132.0s
 => => sha256:795dbedde24d2c72dafd 49.28MB / 49.28MB  74.7s
 => => extracting sha256:795dbedde24d2c72dafd2b71fe36  1.4s
 => => extracting sha256:89d573bf42b377ce6a5a0451c153  0.7s
 => => extracting sha256:26dfe2fac1c486e9aaf41d1028ed  1.9s
 => => extracting sha256:79d5bd8a8d262418bf22e705535c  5.7s
 => => extracting sha256:081ccf923272c30c6072c6ff1617  0.2s
 => => extracting sha256:c9723aa529b03c40e66d0aee927a  0.7s
 => => extracting sha256:91c91c91f1d23f4edf4280a8fe93  0.0s
 => [2/3] WORKDIR /app                                 0.3s
 => [3/3] COPY hello.py .                              0.0s
 => exporting to image                                 0.2s
 => => exporting layers                                0.1s
 => => exporting manifest sha256:af2b6d86756c805919fd  0.0s
 => => exporting config sha256:83a9b2c21f05f62f0aeef2  0.0s
 => => exporting attestation manifest sha256:73368766  0.0s
 => => exporting manifest list sha256:da98e441f555c74  0.0s
 => => naming to docker.io/library/hello-docker:lates  0.0s
 => => unpacking to docker.io/library/hello-docker:la  0.0s
PS C:\Users\emanu\hello-docker> docker run --rm hello-docker

Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    ﻿import sys, numpy
ModuleNotFoundError: No module named 'numpy'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
PS C:\Users\emanu\hello-docker> @'
>> import sys
>> print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
>> '@ | Out-File -FilePath hello.py -Encoding utf8
PS C:\Users\emanu\hello-docker> docker build -t hello-docker .
[+] Building 1.5s (9/9) FINISHED       docker:desktop-linux
 => [internal] load build definition from Dockerfile   0.0s
 => => transferring dockerfile: 113B                   0.0s
 => [internal] load metadata for docker.io/library/py  1.1s
 => [auth] library/python:pull token for registry-1.d  0.0s
 => [internal] load .dockerignore                      0.0s
 => => transferring context: 2B                        0.0s
 => [1/3] FROM docker.io/library/python:3.9@sha256:da  0.0s
 => => resolve docker.io/library/python:3.9@sha256:da  0.0s
 => [internal] load build context                      0.0s
 => => transferring context: 148B                      0.0s
 => CACHED [2/3] WORKDIR /app                          0.0s
 => [3/3] COPY hello.py .                              0.0s
 => exporting to image                                 0.2s
 => => exporting layers                                0.1s
 => => exporting manifest sha256:3969cd77805ba3f753e1  0.0s
 => => exporting config sha256:f2a69870104d4cc9edcf0f  0.0s
 => => exporting attestation manifest sha256:41e6dbc0  0.0s
 => => exporting manifest list sha256:e813609166e8ff0  0.0s
 => => naming to docker.io/library/hello-docker:lates  0.0s
 => => unpacking to docker.io/library/hello-docker:la  0.0s
PS C:\Users\emanu\hello-docker> docker run --rm hello-docker

Hello from Python 3.9 inside a container! ```

## Task 1.2

```powershell
PS C:\Users\emanu\hello-docker> @'                          >> import sys, pandas
>> print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
>> '@ | Out-File -FilePath hello.py -Encoding utf8
PS C:\Users\emanu\hello-docker> docker build -t hello-docker .
[+] Building 1.0s (8/8) FINISHED       docker:desktop-linux
 => [internal] load build definition from Dockerfile   0.0s
 => => transferring dockerfile: 113B                   0.0s
 => [internal] load metadata for docker.io/library/py  0.6s
 => [internal] load .dockerignore                      0.0s
 => => transferring context: 2B                        0.0s
 => [1/3] FROM docker.io/library/python:3.9@sha256:da  0.0s
 => => resolve docker.io/library/python:3.9@sha256:da  0.0s
 => [internal] load build context                      0.0s
 => => transferring context: 154B                      0.0s
 => CACHED [2/3] WORKDIR /app                          0.0s
 => [3/3] COPY hello.py .                              0.0s
 => exporting to image                                 0.2s
 => => exporting layers                                0.0s
 => => exporting manifest sha256:28c2785822527db770c4  0.0s
 => => exporting config sha256:2c44cca4e237b1e9d0d425  0.0s
 => => exporting attestation manifest sha256:47511f92  0.0s
 => => exporting manifest list sha256:a7562c52a5c4d76  0.0s
 => => naming to docker.io/library/hello-docker:lates  0.0s
 => => unpacking to docker.io/library/hello-docker:la  0.0s
PS C:\Users\emanu\hello-docker> docker run --rm hello-docker

Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    ﻿import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
PS C:\Users\emanu\hello-docker> @'
>> FROM python:3.9
>> WORKDIR /app
>> RUN pip install pandas==2.1.0
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
PS C:\Users\emanu\hello-docker> docker build -t hello-docker .
[+] Building 38.8s (10/10) FINISHED    docker:desktop-linux
 => [internal] load build definition from Dockerfile   0.0s
 => => transferring dockerfile: 143B                   0.0s
 => [internal] load metadata for docker.io/library/py  1.2s
 => [auth] library/python:pull token for registry-1.d  0.0s
 => [internal] load .dockerignore                      0.0s
 => => transferring context: 2B                        0.0s
 => [1/4] FROM docker.io/library/python:3.9@sha256:da  0.0s
 => => resolve docker.io/library/python:3.9@sha256:da  0.0s
 => [internal] load build context                      0.0s
 => => transferring context: 29B                       0.0s
 => CACHED [2/4] WORKDIR /app                          0.0s
 => [3/4] RUN pip install pandas==2.1.0               27.5s
 => [4/4] COPY hello.py .                              0.1s
 => exporting to image                                 9.9s
 => => exporting layers                                7.9s
 => => exporting manifest sha256:f55493e29fe6c42cd9e3  0.0s
 => => exporting config sha256:12e7ddeb189056f704676f  0.0s
 => => exporting attestation manifest sha256:b7a0244f  0.0s
 => => exporting manifest list sha256:604a613d38363f3  0.0s
 => => naming to docker.io/library/hello-docker:lates  0.0s
 => => unpacking to docker.io/library/hello-docker:la  1.9s
PS C:\Users\emanu\hello-docker> docker run --rm hello-docker

Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    ﻿import sys, pandas
  File "/usr/local/lib/python3.9/site-packages/pandas/__init__.py", line 46, in <module>
    from pandas.core.api import (
  File "/usr/local/lib/python3.9/site-packages/pandas/core/api.py", line 1, in <module>
    from pandas._libs import (
  File "/usr/local/lib/python3.9/site-packages/pandas/_libs/__init__.py", line 18, in <module>
    from pandas._libs.interval import Interval
  File "interval.pyx", line 1, in init pandas._libs.interval
ValueError: numpy.dtype size changed, may indicate binary incompatibility. Expected 96 from C header, got 88 from PyObject

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
PS C:\Users\emanu\hello-docker> @'
>> FROM python:3.9
>> WORKDIR /app
>> RUN pip install pandas==2.2.2
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
PS C:\Users\emanu\hello-docker> docker build -t hello-docker .
[+] Building 26.8s (10/10) FINISHED    docker:desktop-linux
 => [internal] load build definition from Dockerfile   0.0s
 => => transferring dockerfile: 143B                   0.0s
 => [internal] load metadata for docker.io/library/py  1.0s
 => [auth] library/python:pull token for registry-1.d  0.0s
 => [internal] load .dockerignore                      0.0s
 => => transferring context: 2B                        0.0s
 => [1/4] FROM docker.io/library/python:3.9@sha256:da  0.0s
 => => resolve docker.io/library/python:3.9@sha256:da  0.0s
 => [internal] load build context                      0.0s
 => => transferring context: 29B                       0.0s
 => CACHED [2/4] WORKDIR /app                          0.0s
 => [3/4] RUN pip install pandas==2.2.2               15.0s
 => [4/4] COPY hello.py .                              0.1s
 => exporting to image                                10.5s
 => => exporting layers                                8.4s
 => => exporting manifest sha256:7d2e5d4fb16b913ea4f9  0.0s
 => => exporting config sha256:609bf42ff3d00845a2da7a  0.0s
 => => exporting attestation manifest sha256:f42d315f  0.0s
 => => exporting manifest list sha256:88610fdaa68c5a9  0.0s
 => => naming to docker.io/library/hello-docker:lates  0.0s
 => => unpacking to docker.io/library/hello-docker:la  2.0s
PS C:\Users\emanu\hello-docker> docker run --rm hello-docker

Python 3.9, pandas 2.2.2 

```

# The final Dockerfile 

FROM python:3.9
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]


## Answer 2.1

Not pinning a specific version is a major problem for reproducibility because in this way pip install will always download the latest version of the package. For this reason, if someone runs my Dockerfile in the future, they might get a new version of the package that is not compatible with the version of Python. This is very similar to what happened in my Task 1.2; in fact, I tried to create a Python file with a wrong version of the pandas package for Python 3.9. If this happens, the code is not reproducible and it blocks the runtime. This happens when someone runs the Dockerfile to create the image.

## Answer 2.2

If I want to send my colleague my work and I want this work to be reproducible, I can send both, but I think that the Dockerfile is better because in this way my colleague can read this file and check if there are errors, and he can check the version of the package and the system. If I send just the image, he cannot understand what happened behind this version of code.