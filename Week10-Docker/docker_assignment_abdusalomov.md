# Docker Assignment — Abdusalomov

## Task 1.1
```
base) abdukarimabdusalomov@Abdukarims-MacBook-Air RRcourse2026 % ls
Assignments                     README.md                       Week3                           Week8-MD and Quarto
Data                            Week10-Docker                   Week6                           Week9-Reproducible Environments
ProjectDescriptions             Week2                           Week7-Coding-and-Documentation
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air RRcourse2026 % cd Week10-Docker
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air Week10-Docker % docker --version
zsh: command not found: docker
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air Week10-Docker % docker --version
Docker version 29.4.1, build 055a478
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air Week10-Docker % mkdir hello-docker
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air Week10-Docker % cd hello-docker
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % cat > hello.py << 'EOF'
heredoc> import sys
print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
EOF
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % cat hello.py
import sys
print(f"Hello from Python {sys.version_info.major}.{sys.version_info.minor} inside a container!")
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % python hello.py
Hello from Python 3.13 inside a container!
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % cat > Dockerfile << 'EOF'
heredoc> FROM python:3.11-slim
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
EOF
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker build -t hello-docker .
[+] Building 7.9s (9/9) FINISHED                                                                                                     docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                 0.0s
 => => transferring dockerfile: 115B                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.11-slim                                                                                  3.7s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                        0.0s
 => [internal] load .dockerignore                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                      0.0s
 => [1/3] FROM docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95757cb45945a99fec8e8084b9c2                            3.9s
 => => resolve docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95757cb45945a99fec8e8084b9c2                            0.0s
 => => sha256:e4fb5f1cd4d4ee56da574ef5ed88a5c74f100ba98caacf6c5ef26cee66525179 30.14MB / 30.14MB                                                     3.4s
 => => sha256:61e75fb678e2ee0bfa0b47ea287a2cf604198f951f04cf0cbbb7884058685a0c 248B / 248B                                                           0.3s
 => => sha256:7c9a60876db124ced70648383f11a917724cb96c0efa0e3e385f2f77a9991dab 14.32MB / 14.32MB                                                     1.9s
 => => sha256:6ecad6f632e356308bf250c61fa3ba255caf0b36e3efb607608b55152ece6b0a 1.27MB / 1.27MB                                                       1.0s
 => => extracting sha256:e4fb5f1cd4d4ee56da574ef5ed88a5c74f100ba98caacf6c5ef26cee66525179                                                            0.3s
 => => extracting sha256:6ecad6f632e356308bf250c61fa3ba255caf0b36e3efb607608b55152ece6b0a                                                            0.0s
 => => extracting sha256:7c9a60876db124ced70648383f11a917724cb96c0efa0e3e385f2f77a9991dab                                                            0.1s
 => => extracting sha256:61e75fb678e2ee0bfa0b47ea287a2cf604198f951f04cf0cbbb7884058685a0c                                                            0.0s
 => [internal] load build context                                                                                                                    0.0s
 => => transferring context: 144B                                                                                                                    0.0s
 => [2/3] WORKDIR /app                                                                                                                               0.1s
 => [3/3] COPY hello.py .                                                                                                                            0.0s
 => exporting to image                                                                                                                               0.0s
 => => exporting layers                                                                                                                              0.0s
 => => exporting manifest sha256:6357c76c6265d2d77ae243de3adf2228f1c7681e16abea7a52feea3f784b900c                                                    0.0s
 => => exporting config sha256:d6d5393571080c545ea2daae4386f23f4aa03140cac5baedd55370fadfda1b5a                                                      0.0s
 => => exporting attestation manifest sha256:63e39714fba0b8ddc0815eeff581f63d1c7c6b260a8539b0e95a67fbeb58420a                                        0.0s
 => => exporting manifest list sha256:d1c2484e545f73b29524e770c55ae1ef8cac7f450c53c3b6cd875d000b54f29e                                               0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                               0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                            0.0s
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker run --rm hello-docker
Hello from Python 3.11 inside a container!
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % cat > hello.py << 'EOF'
heredoc> import sys, numpy
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, NumPy {numpy.__version__}")
EOF
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % cat > Dockerfile << 'EOF'
heredoc> FROM python:3.11-slim
WORKDIR /app
RUN pip install numpy==1.26.4
COPY hello.py .
CMD ["python", "hello.py"]
EOF
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker build -t hello-docker .
[+] Building 5.5s (9/9) FINISHED                                                                                                     docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                 0.0s
 => => transferring dockerfile: 145B                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.11-slim                                                                                  0.5s
 => [internal] load .dockerignore                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                      0.0s
 => [1/4] FROM docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95757cb45945a99fec8e8084b9c2                            0.0s
 => => resolve docker.io/library/python:3.11-slim@sha256:6d85378d88a19cd4d76079817532d62232be95757cb45945a99fec8e8084b9c2                            0.0s
 => [internal] load build context                                                                                                                    0.0s
 => => transferring context: 147B                                                                                                                    0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                                        0.0s
 => [3/4] RUN pip install numpy==1.26.4                                                                                                              3.3s
 => [4/4] COPY hello.py .                                                                                                                            0.0s
 => exporting to image                                                                                                                               1.6s
 => => exporting layers                                                                                                                              1.3s
 => => exporting manifest sha256:5c0901cd9e49f6be88f40fcc21718a316bb35e6700bb37efa5c3c0c003bdf732                                                    0.0s
 => => exporting config sha256:e628b6eb7c14718eb682ad13e4638a630c8e7784ddd1127294ecf7b0ec281c78                                                      0.0s
 => => exporting attestation manifest sha256:18f2aca135a56e7f06222c2a991e44a6f6987faa1b24609d54a5cf2d6b52a7ef                                        0.0s
 => => exporting manifest list sha256:77b91e5b1160627d4b0be3a5fd77999c01edaae530054a3693e84a5a79d3d14c                                               0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                               0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                            0.3s
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker run --rm hello-docker                            
Python 3.11, NumPy 1.26.4
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker build -t hello-docker .

[+] Building 11.5s (10/10) FINISHED                                                                                                  docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                 0.0s
 => => transferring dockerfile: 144B                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                   1.4s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                        0.0s
 => [internal] load .dockerignore                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                      0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             4.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => => sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0adb869d47b8c51229 13.83MB / 13.83MB                                                     1.7s
 => => sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3f36914c68455762bf924c 1.27MB / 1.27MB                                                       0.9s
 => => sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad28c2386cb6557943d6 251B / 251B                                                           0.3s
 => => sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3d4f9ce21b0366f47 30.14MB / 30.14MB                                                     3.5s
 => => extracting sha256:a16e551192670581ec8359c70ab9eebf8f2af5468ffc79b3d4f9ce21b0366f47                                                            0.3s
 => => extracting sha256:479b8ad8bcc3edbeba82d4959dfbdc65226d5b55df3f36914c68455762bf924c                                                            0.0s
 => => extracting sha256:ebfe7d4fa0c501a81a5ba6d1e1e2958e4b005d3ce3827b0adb869d47b8c51229                                                            0.1s
 => => extracting sha256:c23f4b50347300e01a1a1da6dd0266adcf8e44671002ad28c2386cb6557943d6                                                            0.0s
 => [internal] load build context                                                                                                                    0.0s
 => => transferring context: 29B                                                                                                                     0.0s
 => [2/4] WORKDIR /app                                                                                                                               0.1s
 => [3/4] RUN pip install numpy==1.26.4                                                                                                              4.4s
 => [4/4] COPY hello.py .                                                                                                                            0.0s
 => exporting to image                                                                                                                               1.5s
 => => exporting layers                                                                                                                              1.3s
 => => exporting manifest sha256:5e0a3c3961e79b8a56a156c684fa6567c0a5d8f50f90438b964bf68f5a5cc90e                                                    0.0s
 => => exporting config sha256:6d4a47fdbec34494f8570a720309ad9395e5149521a429a3eb27d3688ba97789                                                      0.0s
 => => exporting attestation manifest sha256:0a64b047200a0351769ea394771b995dd3fa5234be1c6912529796a8361c9373                                        0.0s
 => => exporting manifest list sha256:ddaaa76ff7de1f35eaadae0c9060929583d0971356153f02a7a224d900f40197                                               0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                               0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                            0.2s
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker run --rm hello-docker

Python 3.9, NumPy 1.26.4
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker build -t hello-docker .

[+] Building 0.6s (9/9) FINISHED                                                                                                     docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                 0.0s
 => => transferring dockerfile: 144B                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                   0.5s
 => [internal] load .dockerignore                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                      0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => [internal] load build context                                                                                                                    0.0s
 => => transferring context: 149B                                                                                                                    0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                                        0.0s
 => CACHED [3/4] RUN pip install numpy==1.26.4                                                                                                       0.0s
 => [4/4] COPY hello.py .                                                                                                                            0.0s
 => exporting to image                                                                                                                               0.0s
 => => exporting layers                                                                                                                              0.0s
 => => exporting manifest sha256:7db92e3fee41e80f0e573d1a97bcb4958b000e6a4ca7613cc931cd7e005ead4f                                                    0.0s
 => => exporting config sha256:6eaaa6835efb2670f8695e6e14be5ef2fd122fad89c5c9516301ee49f6b90605                                                      0.0s
 => => exporting attestation manifest sha256:174ee3abedaecd093f3e99d4c73f31ef485134e99078f63214ca9ac6cedde40a                                        0.0s
 => => exporting manifest list sha256:7020fb6439796f387a6fe19f646b1595ffe7f4e1473bd359385f75c9c094922d                                               0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                               0.0s
 => => unpacking to docker.io/library/hello-docker:latest
```

## Task 1.2  
```
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker run --rm hello-docker  

Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % cat > hello.py << 'EOF'      
import sys, pandas
print(f"Python {sys.version_info.major}.{sys.version_info.minor}, pandas {pandas.__version__}")
EOF

(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker build -t hello-docker .

[+] Building 0.6s (9/9) FINISHED                                                                                                     docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                 0.0s
 => => transferring dockerfile: 144B                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                   0.5s
 => [internal] load .dockerignore                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                      0.0s
 => [1/4] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => [internal] load build context                                                                                                                    0.0s
 => => transferring context: 150B                                                                                                                    0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                                        0.0s
 => CACHED [3/4] RUN pip install numpy==1.26.4                                                                                                       0.0s
 => [4/4] COPY hello.py .                                                                                                                            0.0s
 => exporting to image                                                                                                                               0.0s
 => => exporting layers                                                                                                                              0.0s
 => => exporting manifest sha256:1972b478dac1914e369ebce5b9b54ce7634ad48b5a9995288eb4299e59b2bd24                                                    0.0s
 => => exporting config sha256:e1a7c363af16d081aa21c74ad8440f5f2fcb7479163d7357f39b02ff190c73ef                                                      0.0s
 => => exporting attestation manifest sha256:7078dfa7972008586f8c6ce4ff7366e0ded8a173e790887810896bc173561f8c                                        0.0s
 => => exporting manifest list sha256:f78216b24f8e83f6460d7f4a5b71543b7454afa1be29705e74028736c04602d9                                               0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                               0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                            0.0s
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker run --rm hello-docker

Traceback (most recent call last):
  File "/app/hello.py", line 1, in <module>
    import sys, pandas
ModuleNotFoundError: No module named 'pandas'

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker build -t hello-docker .

[+] Building 6.8s (10/10) FINISHED                                                                                                   docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                 0.0s
 => => transferring dockerfile: 176B                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                                                                                   0.5s
 => [internal] load .dockerignore                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                      0.0s
 => [1/5] FROM docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:2d97f6910b16bd338d3060f261f53f144965f755599aab1acda1e13cf1731b1b                             0.0s
 => [internal] load build context                                                                                                                    0.0s
 => => transferring context: 29B                                                                                                                     0.0s
 => CACHED [2/5] WORKDIR /app                                                                                                                        0.0s
 => CACHED [3/5] RUN pip install numpy==1.26.4                                                                                                       0.0s
 => [4/5] RUN pip install pandas==2.2.2                                                                                                              4.3s
 => [5/5] COPY hello.py .                                                                                                                            0.0s
 => exporting to image                                                                                                                               2.0s 
 => => exporting layers                                                                                                                              1.6s 
 => => exporting manifest sha256:0b7d7dd5b43b33706ee4e8fb0f8c5e9cc8bc3c864ff86f670b2e9e5dabb886ac                                                    0.0s 
 => => exporting config sha256:db4d51d263cd7aee0b3d7569ae3553e6f3d7b8f932215b79faf1ed2d07f02185                                                      0.0s 
 => => exporting attestation manifest sha256:37efef664ef6dd5d406169748e36e56951f5af96f4806c931bd4f3745efaa059                                        0.0s 
 => => exporting manifest list sha256:91aaabab6003c0b1ae4b21520a516e9f85128a2952f46e9db1e010d5e9b6275c                                               0.0s
 => => naming to docker.io/library/hello-docker:latest                                                                                               0.0s
 => => unpacking to docker.io/library/hello-docker:latest                                                                                            0.3s
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % docker run --rm hello-docker

Python 3.9, pandas 2.2.2
(base) abdukarimabdusalomov@Abdukarims-MacBook-Air hello-docker % 
```

### Question 2.1 — Why pin?
Pinning a specific version of pandas ensures that the environment you build tomorrow is identical to the one you built today. If you write RUN pip install pandas without a version, pip will install the newest available release at build time, and that version may introduce API changes, deprecations, or bugs. Your container might suddenly fail to build or produce different results even though you never changed your code. This breaks reproducibility because the same Dockerfile can lead to different environments depending on the date it is built. Pinning freezes the dependency so the “recipe” always produces the same “cake.”

### Question 2.2 — Recipe or cake?
For reproducible research, sending the Dockerfile (the recipe) is better than sending the built image (the cake). A Dockerfile makes the entire environment transparent: every dependency, version, and installation step is visible and auditable. This allows others to rebuild the environment on different machines, verify each step, and detect issues such as outdated packages or missing pins. A built image hides these details and can become outdated or incompatible over time, while the Dockerfile preserves the exact instructions needed to recreate the environment.