# Docker Assignment
Name: Zuzanna Herniczek

---

Task 1.1 — Change the Python version

```
PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> @'
>> FROM python:3.9-slim
>> WORKDIR /app
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> docker build -t hello-docker .
[+] Building 2.9s (8/8) FINISHED                                                 docker:desktop-linux
 => [internal] load build definition from Dockerfile                                             0.0s
 => => transferring dockerfile: 118B                                                             0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                               1.7s
 => [internal] load .dockerignore                                                                0.0s
 => => transferring context: 2B                                                                  0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f75  0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f75  0.1s
 => [internal] load build context                                                                0.0s
 => => transferring context: 29B                                                                 0.0s
 => CACHED [2/3] WORKDIR /app                                                                    0.0s
 => [3/3] COPY hello.py .                                                                        0.1s
 => exporting to image                                                                           0.6s
 => => exporting layers                                                                          0.2s
 => => exporting manifest sha256:2e09ced026a5ee84cffcfb60896bc869f751ea49ec8bf346a5d50e6e394a10  0.0s
 => => exporting config sha256:7b113cdbd318058d44ee7e0164b4f2af3fa0d519a8d0632f111b536d7b6f6edf  0.0s
 => => exporting attestation manifest sha256:a0e5e69f7eb1dee6d4d5416fcbbd6978b741b91491c61481a6  0.1s
 => => exporting manifest list sha256:ebd6cb18c3a71afa6d8b8169171624da711ee7526ea53ab7e011368d7  0.0s
 => => naming to docker.io/library/hello-docker:latest                                           0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                        0.1s

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

---

Task 1.2

```
PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> @'
>> import sys, pandas
>> print(f"Python {sys.version_info.major}.{sys.version_info.minor}, Pandas {pandas.__version__}")
>> '@ | Out-File -FilePath hello.py -Encoding utf8

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> docker build -t hello-docker .
[+] Building 3.3s (8/8) FINISHED                                                 docker:desktop-linux
 => [internal] load build definition from Dockerfile                                             0.0s
 => => transferring dockerfile: 118B                                                             0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                               2.3s
 => [internal] load .dockerignore                                                                0.0s
 => => transferring context: 2B                                                                  0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f75  0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f75  0.1s
 => [internal] load build context                                                                0.0s
 => => transferring context: 154B                                                                0.0s
 => CACHED [2/3] WORKDIR /app                                                                    0.0s
 => [3/3] COPY hello.py .                                                                        0.0s
 => exporting to image                                                                           0.5s
 => => exporting layers                                                                          0.2s
 => => exporting manifest sha256:ff6b56da0ef65d8acf919c4a426e19eac513f77e260a430bdfde270ea05a64  0.0s
 => => exporting config sha256:df88d493f79e173b2e9c76b92cf553dce913a2a72f4806b74530888fab50a684  0.0s
 => => exporting attestation manifest sha256:e7bc07fc0d511af66be3363fee5ca2a077ef21224e066956b6  0.1s
 => => exporting manifest list sha256:79a4150bec7ca80ca703c44a8a7294649bbeb1b411d56c4e3ac8f0655  0.0s
 => => naming to docker.io/library/hello-docker:latest                                           0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                        0.1s

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> @'
>> FROM python:3.11-slim
>> WORKDIR /app
>> RUN pip install pandas==2.3.3
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> docker build -t hello-docker .
[+] Building 37.6s (9/9) FINISHED                                                docker:desktop-linux
 => [internal] load build definition from Dockerfile                                             0.0s
 => => transferring dockerfile: 149B                                                             0.0s
 => [internal] load metadata for docker.io/library/python:3.11-slim                              1.0s
 => [internal] load .dockerignore                                                                0.0s
 => => transferring context: 2B                                                                  0.0s
 => [1/4] FROM docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95  0.1s
 => => resolve docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95  0.1s
 => [internal] load build context                                                                0.0s
 => => transferring context: 29B                                                                 0.0s
 => CACHED [2/4] WORKDIR /app                                                                    0.0s
 => [3/4] RUN pip install pandas==2.3.3                                                         23.9s
 => [4/4] COPY hello.py .                                                                        0.1s
 => exporting to image                                                                          12.0s
 => => exporting layers                                                                          8.8s
 => => exporting manifest sha256:a223737dff3a4b0637329838242f15585eab36b3ad8a7d22064eb4158d63cd  0.0s
 => => exporting config sha256:25de234ea6b6761f6bc2876b8db86af062cf63b2b1badba001111b630f567f46  0.0s
 => => exporting attestation manifest sha256:da7823f80180ff9f04486433735cca9eea1b65f852f1a7139e  0.1s
 => => exporting manifest list sha256:c492a19b53f6ff5313d2197a1abf176ac9fb0a1018f4db6d4f51dad6e  0.0s
 => => naming to docker.io/library/hello-docker:latest                                           0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                        2.9s

PS C:\Users\GHE\Desktop\studia\rr\rrcourse2026\hello-docker> docker run --rm hello-docker
Python 3.11, Pandas 2.3.3
```

Final Dockerfile:

```dockerfile
FROM python:3.11-slim
WORKDIR /app
RUN pip install pandas==2.3.3
COPY hello.py .
CMD ["python", "hello.py"]
```

---

Question 2.1

Running `RUN pip install pandas` without a specified version would mean that each person who tries to reproduce this code will get a different pandas version, which may lead to some issues with how libraries interact together and may break the code. Someone who runs this code in a couple of months would get an entirely different pandas version, which may not work with the code provided, creating an issue for reproducibulity. 

Question 2.2

Sharing the Dockerfile and `hello.py` is better for reproducible research than sharing the built image. The most important reason, other than it being more convenient, is that it is a readable text, which allows other people looking at it to know what is inside the environment and easily modify it. If we were to send a built image, it is kind of like a black box, which makes it harder to review.