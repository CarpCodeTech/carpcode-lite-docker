# carpcode-lite-docker
 Build kaldi inside docker containers with option for CUDA support

To build and run basic carpcode-lite image use the following commands:

```
sudo docker build -t carpcode-lite:1.0.0 .
sudo docker run -v <Absolute_Path_Audio_Files_Directory_Path>:/opt/audio -it carpcode-lite:1.0.0 ./decode.sh
```

To compile Kaldi with CUDA support you must first install the 
[`nvidia-docker` utilities](https://github.com/NVIDIA/nvidia-docker/releases).

Then run

```
nvidia-docker build -t carpcode-lite kaldi-gpu/
nvidia-docker run -ti carpcode-lite
```

You can set the following arguments when building Kaldi:

- `NUM_BUILD_CORES`: The numbers of cores used for the compilation. Default: 8.
- `OPENFST_VERSION`: The version of OpenFST library Kaldi will build against. Default: 1.4.1.

This is based on https://github.com/jbender/docker-kaldi

You can also pull the prebuilt containers from [Docker Hub](https://hub.docker.com/r/georgepar/kaldi/)
