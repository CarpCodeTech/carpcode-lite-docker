# carpcode-lite-docker
 Build kaldi inside docker containers with option for CUDA support

To build and run basic carpcode-lite image use the following commands:

```
sudo docker build -t carpcode-lite:1.0.0 .
sudo docker run -v <Absolute_Path_Audio_Files_Directory_Path>:/opt/audio -it carpcode-lite:1.0.0 ./decode.sh <JOB>
```
