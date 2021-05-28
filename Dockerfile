FROM kaldiasr/kaldi
MAINTAINER Yang Yu <yyu.speech@gmail.com>


ADD exp/. /opt/kaldi/exp
ADD PrepareAudio.py /opt/kaldi/
ADD decode.sh /opt/kaldi/
