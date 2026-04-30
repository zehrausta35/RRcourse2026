## Task 1.1
```powershell
[+] Building 2.0s (9/9) FINISHED                                                                   docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 118B                                                                               0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                 1.1s
 => [auth] library/python:pull token for registry-1.docker.io                                                      0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [1/3] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf  0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf  0.1s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 148B                                                                                  0.0s
 => CACHED [2/3] WORKDIR /app                                                                                      0.0s
 => CACHED [3/3] COPY hello.py .                                                                                   0.0s
 => exporting to image                                                                                             0.3s
 => => exporting layers                                                                                            0.0s
 => => exporting manifest sha256:cf9f8e5973c433296233b468fdee84e1c3c7fea8625596d8c958de89ff74e7b5                  0.0s
 => => exporting config sha256:528e31404fae8362c844b1f6f781fa8c4badccdb7625a23afc01eed81cef741e                    0.0s
 => => exporting attestation manifest sha256:ef725c2f3fdd90138484f0cfcae6bdeee18cbb04f95fd3b38601a6c91951602a      0.1s
 => => exporting manifest list sha256:f6f6f63fb2113d268aa1eda38ed46522db5623ccd021289fee636b9f00e34de1             0.0s
 => => naming to docker.io/library/hello-docker:latest                                                             0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                          0.1s
PS C:\Users\admin\Desktop\hello-docker> docker run --rm hello-docker
Hello from Python 3.9 inside a container!
```

## task 1.2
### Failed run
```powershell
PS C:\Users\admin\Desktop\hello-docker> docker run --rm hello-docker
Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    ﻿import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
```
### Fixed run
```powershell
PS C:\Users\admin\Desktop\hello-docker> @'
>> FROM python:3.9-slim
>> WORKDIR /app
>> RUN pip install pandas==2.2.2
>> COPY hello.py .
>> CMD ["python", "hello.py"]
>> '@ | Out-File -FilePath Dockerfile -Encoding utf8
[+] Building 49.0s (10/10) FINISHED                                                                docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                               0.1s
 => => transferring dockerfile: 148B                                                                               0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                 0.9s
 => [auth] library/python:pull token for registry-1.docker.io                                                      0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf  0.1s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf  0.1s
 => [internal] load build context                                                                                  0.0s
 => => transferring context: 29B                                                                                   0.0s
 => CACHED [2/4] WORKDIR /app                                                                                      0.0s
 => [3/4] RUN pip install pandas==2.2.2                                                                           29.2s
 => [4/4] COPY hello.py .                                                                                          0.2s
 => exporting to image                                                                                            18.2s
 => => exporting layers                                                                                           12.6s
 => => exporting manifest sha256:3a81b9a4766a8a3ee8e983d7e713d516f56d99efca649fcd24b8e66fbb286780                  0.0s
 => => exporting config sha256:d158a40d289bf55f60489acf24cd739a57902edb6da098bbc4fe3bf2b12574a4                    0.0s
 => => exporting attestation manifest sha256:29db16b7becba255d388c8b9fdfba3c6459ee5a7499f0f8404b2d44b241cb177      0.1s
 => => exporting manifest list sha256:6b6f8542626c97e4f3fbf1f8bce335a08a6f760fb9e2505bf237e3ae981a89fc             0.0s
 => => naming to docker.io/library/hello-docker:latest                                                             0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                          5.4s
PS C:\Users\admin\Desktop\hello-docker> ^C
PS C:\Users\admin\Desktop\hello-docker> docker run --rm hello-docker
Python 3.9, pandas 2.2.2
```


## Final Dockerfile
```dockerfile
FROM python:3.9-slim
WORKDIR /app
RUN pip install pandas==2.2.2
COPY hello.py .
CMD ["python", "hello.py"]
```

## task 2.1
If I do not pin the pandas version, Docker may install a different version in the future. The code may still work today, but later it could give different results or stop working because pandas changed something. For example, functions, defaults, or dependencies may be different in a newer release. That would make the project less reproducible, because rebuilding the same Dockerfile at another time would not give exactly the same environment.

## task 2.2
For reproducible research, I think sending the Dockerfile and hello.py is better. A Dockerfile shows exactly how the environment is built, so another person can inspect it, understand it, and rebuild it themselves. This is important in research, because transparency matters as much as getting the same output. A built image can run the code, but it hides many details of how that environment was created.