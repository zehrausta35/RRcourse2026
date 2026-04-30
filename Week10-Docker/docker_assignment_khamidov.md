placeholder
## task1.1
### Building and running with Python 3.11
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker> cd hello-docker
>> 
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
>> 
[+] Building 6.9s (9/9) FINISHED                                                                                                                                                                         docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                                                     0.1s
 => => transferring dockerfile: 119B                                                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.11-slim                                                                                                                                                      2.3s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                                                                                            0.0s
 => [internal] load .dockerignore                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                          0.0s
 => [1/3] FROM docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95757cb45945a99fec8e8084b9c2                                                                                                3.8s
 => => resolve docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95757cb45945a99fec8e8084b9c2                                                                                                0.0s
 => => sha256:f3ba2250c52436e41e9f2f3830af92de466fcacc2d848264e1f9fdc76975d803 14.37MB / 14.37MB                                                                                                                         1.2s
 => => sha256:7ccd73948dde4b7f1623ac6bf9b58706fb83d0a363d765d7c799d46035ceb563 249B / 249B                                                                                                                               0.5s
 => => sha256:91ff8760033c3b9bc9c3a3bcc6ff66c113ec9e13f94fa2f12ae4b221aae996b9 1.29MB / 1.29MB                                                                                                                           1.1s
 => => sha256:3531af2bc2a9c8883754652783cf96207d53189db279c9637b7157d034de7ecd 29.78MB / 29.78MB                                                                                                                         2.7s
 => => extracting sha256:3531af2bc2a9c8883754652783cf96207d53189db279c9637b7157d034de7ecd                                                                                                                                0.6s
 => => extracting sha256:91ff8760033c3b9bc9c3a3bcc6ff66c113ec9e13f94fa2f12ae4b221aae996b9                                                                                                                                0.1s
 => => extracting sha256:f3ba2250c52436e41e9f2f3830af92de466fcacc2d848264e1f9fdc76975d803                                                                                                                                0.3s
 => => extracting sha256:7ccd73948dde4b7f1623ac6bf9b58706fb83d0a363d765d7c799d46035ceb563                                                                                                                                0.0s
 => [internal] load build context                                                                                                                                                                                        0.1s
 => => transferring context: 148B                                                                                                                                                                                        0.0s
 => [2/3] WORKDIR /app                                                                                                                                                                                                   0.1s
 => [3/3] COPY hello.py .                                                                                                                                                                                                0.1s
 => exporting to image                                                                                                                                                                                                   0.3s
 => => exporting layers                                                                                                                                                                                                  0.1s
 => => exporting manifest sha256:e464744c7e52f094117c5fea59194507082f7b928c24bd26a230bc2b1f37e445                                                                                                                        0.0s
 => => exporting config sha256:37838ef86580f26fded09ea7d5264fb44a71ccc0498173e90bb516cbff9de8b6                                                                                                                          0.0s
 => => exporting attestation manifest sha256:914fce3cc6a6711819735962a7c33bad3cfd035c285fc1155407cb5f3cd9980f                                                                                                            0.0s
 => => exporting manifest list sha256:7f2235aaac57d3b35436de411c067af69d7154286315921a58aba4aacc494d58                                                                                                                   0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                                                                                                   0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                                                                                                0.0s
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> docker run --rm hello-docker
>> 
Hello from Python 3.11 inside a container!


### Switch to Python 3.9, rebuild and run

PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> @'
>> FROM python:3.9-slim
>> WORKDIR /app
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
>> 
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> type Dockerfile
>> 
FROM python:3.9-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
>> docker run --rm hello-docker
>> 
[+] Building 6.5s (8/8) FINISHED                                                                                                                                                                         docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                                                     0.0s
 => => transferring dockerfile: 118B                                                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                                                                                       1.3s
 => [internal] load .dockerignore                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                          0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                                                                                 4.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                                                                                 0.0s
 => => sha256:fc74430849022d13b0d44b8969a953f842f59c6e9d1a0c2c83d710affa286c08 13.88MB / 13.88MB                                                                                                                         1.2s
 => => sha256:ea56f685404adf81680322f152d2cfec62115b30dda481c2c450078315beb508 251B / 251B                                                                                                                               0.5s
 => => sha256:b3ec39b36ae8c03a3e09854de4ec4aa08381dfed84a9daa075048c2e3df3881d 1.29MB / 1.29MB                                                                                                                           1.0s
 => => sha256:38513bd7256313495cdd83b3b0915a633cfa475dc2a07072ab2c8d191020ca5d 29.78MB / 29.78MB                                                                                                                         2.8s
 => => extracting sha256:38513bd7256313495cdd83b3b0915a633cfa475dc2a07072ab2c8d191020ca5d                                                                                                                                0.6s
 => => extracting sha256:b3ec39b36ae8c03a3e09854de4ec4aa08381dfed84a9daa075048c2e3df3881d                                                                                                                                0.1s
 => => extracting sha256:fc74430849022d13b0d44b8969a953f842f59c6e9d1a0c2c83d710affa286c08                                                                                                                                0.3s
 => => extracting sha256:ea56f685404adf81680322f152d2cfec62115b30dda481c2c450078315beb508                                                                                                                                0.0s
 => [internal] load build context                                                                                                                                                                                        0.0s
 => => transferring context: 29B                                                                                                                                                                                         0.0s
 => [2/3] WORKDIR /app                                                                                                                                                                                                   1.0s
 => [3/3] COPY hello.py .                                                                                                                                                                                                0.0s
 => exporting to image                                                                                                                                                                                                   0.2s
 => => exporting layers                                                                                                                                                                                                  0.1s
 => => exporting manifest sha256:d8510235b4f6fa91640e803b4914395edb9f4456dcb6b1382178276067445d31                                                                                                                        0.0s
 => => exporting config sha256:0afaf5b5a66dafe07dfc878c592e6b98da9f4dfa378100f81bbaa2fea7753a7a                                                                                                                          0.0s
 => => exporting attestation manifest sha256:17ff6d563524418c31aa8387ba791e7a939df4f856ac141ce2fdf026d9121747                                                                                                            0.0s
 => => exporting manifest list sha256:fb4af1467a3fa40fe0584d6552d81b2c0c7282bcd2e002d8921596b9f624f322                                                                                                                   0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                                                                                                   0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                                                                                                0.0s
Hello from Python 3.9 inside a container!



---

## Task 1.2

### hello.py requiring pandas

PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> @'
>> import sys, pandas
>> print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
>> '@ | Out-File -FilePath hello.py -Encoding utf8
>> 
>> type hello.py
>> 
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
>> docker run --rm hello-docker
>> 
[+] Building 1.2s (9/9) FINISHED                                                                                                                                                                         docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                                                     0.0s
 => => transferring dockerfile: 118B                                                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                                                                                       0.8s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                                                                                            0.0s
 => [internal] load .dockerignore                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                          0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                                                                                 0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                                                                                 0.0s
 => [internal] load build context                                                                                                                                                                                        0.0s
 => => transferring context: 154B                                                                                                                                                                                        0.0s
 => CACHED [2/3] WORKDIR /app                                                                                                                                                                                            0.0s
 => [3/3] COPY hello.py .                                                                                                                                                                                                0.0s
 => exporting to image                                                                                                                                                                                                   0.2s
 => => exporting layers                                                                                                                                                                                                  0.1s
 => => exporting manifest sha256:8e827aae4f1f1e27db3fcbcce60f2c5c901c5407711590fa77c8777628cc0990                                                                                                                        0.0s
 => => exporting config sha256:8c30f64a3ba02509bb44779eac1d64ac6b25d32b11f0a7d9dbe26ff36271faee                                                                                                                          0.0s
 => => exporting attestation manifest sha256:b697f096afba82b91e65455af74edf8f74f8870b9130bc11c947da173a2fe0bb                                                                                                            0.0s
 => => exporting manifest list sha256:bd912cb875554f35ac861ba1d13d9323c61ba67d46e4060d94bbf656d3f13adc                                                                                                                   0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                                                                                                   0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                                                                                                0.0s
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

## task 1.2 Fixing error
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> @'
>> FROM python:3.9-slim
>> WORKDIR /app
>> RUN pip install pandas==2.2.2
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
>> 
>> type Dockerfile
>> 
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]
PS C:\Users\khami\Desktop\University of Warsaw\4 semester\Reproducible research\RRcourse2026\RRcourse2026\Week10-Docker\hello-docker> docker build -t hello-docker .
>> docker run --rm hello-docker
>> 
[+] Building 21.4s (9/9) FINISHED                                                                                                                                                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                                                     0.0s
 => => transferring dockerfile: 148B                                                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                                                                                       0.6s
 => [internal] load .dockerignore                                                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                                          0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                                                                                 0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                                                                                                 0.0s
 => [internal] load build context                                                                                                                                                                                        0.0s
 => => transferring context: 29B                                                                                                                                                                                         0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                                                                                                            0.0s
 => [3/4] RUN pip install pandas==2.2.2                                                                                                                                                                                 13.6s
 => [4/4] COPY hello.py .                                                                                                                                                                                                0.1s 
 => exporting to image                                                                                                                                                                                                   7.1s 
 => => exporting layers                                                                                                                                                                                                  5.8s 
 => => exporting manifest sha256:79b6f5fd42a046f559007734b3dbf5bb275415020216fe25df593c80f763f012                                                                                                                        0.0s 
 => => exporting config sha256:cf33ac60abe49c309853b0c3ff61ed6e249083288fb54957d66c7566007adcd2                                                                                                                          0.0s 
 => => exporting attestation manifest sha256:6ee1a61904a19cf3a6486db4c70994c1111e2a140c41b4800fd3c6c32e2b15a1                                                                                                            0.0s 
 => => exporting manifest list sha256:adcad1680a0882a49e46437315685cc5cd48dd1b14006e11cf4f93790ec2a4b1                                                                                                                   0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                                                                                                   0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                                                                                                1.2s
Python 3.9, pandas 2.2.2


##  final Dockerfile pasted as text

FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]

## Question 2.1  Why pin?  Answer
Pinning a package version is essential because it locks your environment to a specific, known state. If you simply write pip install pandas without a version, Docker will always install the newest release available at build time. That means your container might work today, but break in the future if pandas introduces changes, removes functions, or alters default behavior. This creates a reproducibility problem: the same Dockerfile could produce different results depending on when it’s built. By pinning the version, you guarantee that anyone rebuilding the image—tomorrow or years from now—gets the exact same dependency and therefore the same behavior.

## Question 2.2   Recipe or cake?  Answer
For reproducible research, sharing the Dockerfile (the “recipe”) is much better than sharing only the prebuilt image (the “cake”). The Dockerfile makes the entire environment transparent: every step, dependency, and version is written down and can be rebuilt on any machine. A prebuilt image hides how it was created and may stop working in the future if the registry disappears or the image becomes incompatible with new systems. With the Dockerfile, your colleague can always recreate the environment from scratch, inspect it, and verify exactly what it contains — which is the whole point of reproducibility.