# Docker Assignment – Rajat Dogra

## Task 1.1 – Change the Python version

Changed the base image in `Dockerfile` from `python:3.11-slim` to `python:3.9-slim`, then rebuilt and ran the container.

```
$ docker build -t hello-docker .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 114B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE 1.8s

#3 [auth] library/python:pull token for registry-1.docker.io
#3 DONE 0.0s

#4 [internal] load .dockerignore
#4 transferring context: 2B done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 144B done
#5 DONE 0.0s

#6 [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b
#6 resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b 0.0s done
#6 sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3d4f9ce21b0366f47 0B / 30.14MB 0.0s
#6 sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0adb869d47b8c51229 0B / 13.83MB 0.2s
#6 sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3f36914c68455762bf924c 0B / 1.27MB 0.2s
#6 sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad28c2386cb6557943d6 251B / 251B 0.3s done
#6 sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0adb869d47b8c51229 13.83MB / 13.83MB 2.4s done
#6 sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3d4f9ce21b0366f47 30.14MB / 30.14MB 4.6s done
#6 extracting sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3d4f9ce21b0366f47 0.4s done
#6 extracting sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0adb869d47b8c51229 0.2s done
#6 extracting sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3f36914c68455762bf924c done
#6 extracting sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad28c2386cb6557943d6 done
#6 DONE 5.2s

#7 [2/3] WORKDIR /app
#7 DONE 0.1s

#8 [3/3] COPY hello.py .
#8 DONE 0.0s

#9 exporting to image
#9 exporting layers done
#9 naming to docker.io/library/hello-docker:latest done
#9 unpacking to docker.io/library/hello-docker:latest done
#9 DONE 0.1s

$ docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

---

## Task 1.2 – Break and fix the Dockerfile

### Step 1: Replace `hello.py` with the pandas version and rebuild

Updated `hello.py` to:

```python
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
```

Rebuilt (no change to Dockerfile — pandas is not installed in the image):

```
$ docker build -t hello-docker .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 114B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE 0.9s

#3 [auth] library/python:pull token for registry-1.docker.io
#3 DONE 0.0s

#4 [internal] load .dockerignore
#4 transferring context: 2B done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 150B done
#5 DONE 0.0s

#6 [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b
#6 resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b done
#6 DONE 0.0s

#7 [2/3] WORKDIR /app
#7 CACHED

#8 [3/3] COPY hello.py .
#8 DONE 0.0s

#9 exporting to image
#9 exporting layers done
#9 naming to docker.io/library/hello-docker:latest done
#9 unpacking to docker.io/library/hello-docker:latest done
#9 DONE 0.0s

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'
```

**Error:** The container does not have pandas installed. The base `python:3.9-slim` image includes only the Python standard library; pandas must be explicitly installed.

---

### Step 2: Fix the Dockerfile by pinning pandas

Added one line to install a specific version of pandas:

```
RUN pip install pandas==2.2.2
```

Rebuilt and ran:

```
$ docker build -t hello-docker .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 144B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE 0.2s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 29B done
#4 DONE 0.0s

#5 [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b
#5 resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b done
#5 DONE 0.0s

#6 [2/4] WORKDIR /app
#6 CACHED

#7 [3/4] RUN pip install pandas==2.2.2
#7 1.255 Collecting pandas==2.2.2
#7 1.333   Downloading pandas-2.2.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (15.7 MB)
#7 2.749      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 15.7/15.7 MB 11.2 MB/s eta 0:00:00
#7 2.855 Collecting pytz>=2020.1
#7 2.921      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 510.5/510.5 kB 11.5 MB/s eta 0:00:00
#7 3.232 Collecting numpy>=1.22.4
#7 3.253   Downloading numpy-2.0.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (13.9 MB)
#7 4.470      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 13.9/13.9 MB 11.3 MB/s eta 0:00:00
#7 4.612 Collecting tzdata>=2022.7
#7 4.579      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 349.3/349.3 kB 11.5 MB/s eta 0:00:00
#7 4.612 Collecting python-dateutil>=2.8.2
#7 4.653      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.9/229.9 kB 11.5 MB/s eta 0:00:00
#7 4.693 Collecting six>=1.5
#7 4.795 Installing collected packages: pytz, tzdata, six, numpy, python-dateutil, pandas
#7 7.542 Successfully installed numpy-2.0.2 pandas-2.2.2 python-dateutil-2.9.0.post0 pytz-2026.1.post1 six-1.17.0 tzdata-2026.2
#7 DONE 7.9s

#8 [4/4] COPY hello.py .
#8 DONE 0.0s

#9 exporting to image
#9 exporting layers 2.9s done
#9 naming to docker.io/library/hello-docker:latest done
#9 unpacking to docker.io/library/hello-docker:latest done
#9 DONE 3.6s

$ docker run --rm hello-docker
Python 3.9, pandas 2.2.2
```

### Final Dockerfile

```dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]
```

---

## Question 2.1 – Why pin?

Without pinning, `pip install pandas` fetches whatever version is newest at build time. This is a reproducibility problem because the pandas API changes between major versions — for example, pandas 2.x removed several functions that existed in 1.x, so code written and tested against one version may silently produce different results or crash entirely when built later against a newer one. Someone who clones your repository six months from now and runs `docker build` could get a completely different pandas version than you used, and there is no way to detect this without explicit version pinning. The build would succeed but the results — or even the behaviour of the script — could differ, undermining the entire point of the container.

## Question 2.2 – Recipe or cake?

For reproducible research, sharing the **Dockerfile and source files** (the recipe) is better than sharing only the built image (the cake). A built image is a black box: it encodes every decision — base OS version, installed packages, file contents — without making any of it legible. A reviewer or future researcher cannot audit what is inside it, cannot trace *why* a specific library version was chosen, and cannot verify that the image was not modified after the fact. The Dockerfile, by contrast, is a transparent, version-controllable, human-readable record of every step taken to construct the environment, which is exactly what scientific reproducibility requires.
