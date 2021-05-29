FROM kaldiasr/kaldi
MAINTAINER Yang Yu <yyu.speech@gmail.com>

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak 
ADD sources.list /etc/apt/

RUN apt-get update && apt-get install -y --allow-unauthenticated python-pip nano

RUN pip install tqdm

ADD exp/. /opt/kaldi/exp
ADD PrepareAudio.py /opt/kaldi/
ADD decode.sh /opt/kaldi/
ADD Monitor.py /opt/kaldi/
