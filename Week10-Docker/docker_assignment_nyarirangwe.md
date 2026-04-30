# Docker Assignment

## Task 1.1 — Change the Python version

```bash
$ docker build -t hello-docker .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 117B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE 0.6s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 29B done
#4 DONE 0.0s

#5 [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b
#5 resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b 0.0s done
#5 DONE 0.0s

#6 [2/3] WORKDIR /app
#6 CACHED

#7 [3/3] COPY hello.py .
#7 CACHED

#8 exporting to image
#8 exporting layers done
#8 exporting manifest sha256:4c4309d938448508b92dd8aa08a8c930760cbdbe1b9a39fd342fad2c492c5274 done
#8 exporting config sha256:2cda91510df04ba023db13d3a65b5c3409fbc2d2f1959fa44cb68fadd740bf2a done
#8 exporting attestation manifest sha256:ca4f091df28cadeba8051adaf3c9bf3d7725ba97b6389a93e6ca115ac18543b7 done
#8 exporting manifest list sha256:09146d4c09067738e493982aaea07b02ff043da79c11119f5e7a3a287d52c5c0 done
#8 naming to docker.io/library/hello-docker:latest done
#8 unpacking to docker.io/library/hello-docker:latest done
#8 DONE 0.0s

$ docker run --rm hello-docker
Hello from Python 3.9 inside a container!

```

## Task 1.2 — Break and fix the Dockerfile

### Failed run

```bash
$ docker build -t hello-docker .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 117B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE 0.3s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 150B done
#4 DONE 0.0s

#5 [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b
#5 resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b 0.0s done
#5 DONE 0.0s

#6 [2/3] WORKDIR /app
#6 CACHED

#7 [3/3] COPY hello.py .
#7 DONE 0.0s

#8 exporting to image
#8 exporting layers 0.0s done
#8 exporting manifest sha256:e0a3613b23159b42803acb0dc406bb9ad945287d2f6a047d42fbb5d43e9b4b59 0.0s done
#8 exporting config sha256:2871d0a16eee6820de2a8076374ad6581dc794b8ab46898f9daae028a927487d done
#8 exporting attestation manifest sha256:133eb6e3599158c0f8ba5410ec5b7421f335c83a963492a99e8880594a7e4854 0.0s done
#8 exporting manifest list sha256:4251000c12d8329160cce0eb624c5c6010e9b36f3a02d0d21944adb5f725028e done
#8 naming to docker.io/library/hello-docker:latest
#8 naming to docker.io/library/hello-docker:latest done
#8 unpacking to docker.io/library/hello-docker:latest 0.0s done
#8 DONE 0.1s

$ docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

```

### Successful run after fixing the Dockerfile

```bash
$ docker build -t hello-docker .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 163B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/python:3.9-slim
#2 DONE 0.3s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 29B done
#4 DONE 0.0s

#5 [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b
#5 resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b 0.0s done
#5 DONE 0.0s

#6 [2/4] WORKDIR /app
#6 CACHED

#7 [3/4] RUN pip install --no-cache-dir pandas==2.2.3
#7 2.222 Collecting pandas==2.2.3
#7 2.397   Downloading pandas-2.2.3-cp39-cp39-manylinux2014_aarch64.manylinux_2_17_aarch64.whl (15.6 MB)
#7 15.63      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 15.6/15.6 MB 1.2 MB/s eta 0:00:00
#7 16.62 Collecting numpy>=1.22.4
#7 16.66   Downloading numpy-2.0.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (13.9 MB)
#7 28.43      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 13.9/13.9 MB 1.2 MB/s eta 0:00:00
#7 28.52 Collecting python-dateutil>=2.8.2
#7 28.55   Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl (229 kB)
#7 28.72      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.9/229.9 kB 1.4 MB/s eta 0:00:00
#7 28.79 Collecting tzdata>=2022.7
#7 28.82   Downloading tzdata-2026.2-py2.py3-none-any.whl (349 kB)
#7 29.10      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 349.3/349.3 kB 1.3 MB/s eta 0:00:00
#7 29.25 Collecting pytz>=2020.1
#7 29.28   Downloading pytz-2026.1.post1-py2.py3-none-any.whl (510 kB)
#7 29.69      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 510.5/510.5 kB 1.2 MB/s eta 0:00:00
#7 29.76 Collecting six>=1.5
#7 29.79   Downloading six-1.17.0-py2.py3-none-any.whl (11 kB)
#7 29.95 Installing collected packages: pytz, tzdata, six, numpy, python-dateutil, pandas
#7 36.26 Successfully installed numpy-2.0.2 pandas-2.2.3 python-dateutil-2.9.0.post0 pytz-2026.1.post1 six-1.17.0 tzdata-2026.2
#7 36.26 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
#7 36.45 
#7 36.45 [notice] A new release of pip is available: 23.0.1 -> 26.0.1
#7 36.45 [notice] To update, run: pip install --upgrade pip
#7 DONE 36.8s

#8 [4/4] COPY hello.py .
#8 DONE 0.1s

#9 exporting to image
#9 exporting layers
#9 exporting layers 5.0s done
#9 exporting manifest sha256:24c5c5808e9e770b4f498f4e20fdbeaeb460e3bf5b7535fcb8a78dda98112fdc done
#9 exporting config sha256:a68dda7cabe14a6e802ead6a613b90419cd1602ee9255179cd88d0a21710c554 done
#9 exporting attestation manifest sha256:64ed83b2db91483d6622592dd75e46345ff622b5fd466273052273315ea2a362 done
#9 exporting manifest list sha256:2ea707781559c5f0eac5c6ba58a148ad6e4ee4dd9a1730967eb544284653fd38 done
#9 naming to docker.io/library/hello-docker:latest done
#9 unpacking to docker.io/library/hello-docker:latest
#9 unpacking to docker.io/library/hello-docker:latest 1.0s done
#9 DONE 6.1s

$ docker run --rm hello-docker
Python 3.9, pandas 2.2.3

```

### Final Dockerfile

```Dockerfile
FROM python:3.9-slim

WORKDIR /app

RUN pip install --no-cache-dir pandas==2.2.3

COPY hello.py .

CMD ["python", "hello.py"]

```

## Question 2.1 — Why pin?

If I write `RUN pip install pandas` without a version, Docker will install the pandas version that is available at the time of building the image. This is a reproducibility problem because the same Dockerfile could install a different pandas version in the future. A newer version might change behavior, remove features, or create compatibility problems with the code. Pinning pandas makes the environment more stable because the same version is installed each time.

## Question 2.2 — Recipe or cake?

For reproducible research, sending the Dockerfile and `hello.py` is better because it shows the exact recipe used to create the environment. The colleague can inspect the steps, rebuild the environment, and understand which dependencies were installed. A built image may work, but it is less transparent because the contents are harder to review. The Dockerfile is also easier to track in Git, so changes to the research environment can be clearly compared over time.
