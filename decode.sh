#!/bin/bash

JOB=1
if [ $# == 1 ] ; then
    JOB=$1
fi

echo $JOB > JOB

split_scps=""
split_spk2utt=""
for n in $(seq $JOB); do
    split_scps="$split_scps wav.$n.scp"
    split_spk2utt="$split_spk2utt spk2utt.$n"
done

rm *.log &> /dev/null

# Generate and Split wav.scp and spk2utt
python PrepareAudio.py /opt/audio wav.scp spk2utt
egs/wsj/s5/utils/split_scp.pl wav.scp $split_scps
egs/wsj/s5/utils/split_scp.pl spk2utt $split_spk2utt

PYTHONIOENCODING=utf-8 python Monitor.py &

perl egs/wsj/s5/utils/run.pl JOB=1:$JOB JOB.log\
 src/online2bin/online2-wav-nnet3-latgen-faster \
 --do-endpointing=false --print-args=false --verbose=-1 \
 --frames-per-chunk=20 --extra-left-context-initial=0 \
 --online=true --frame-subsampling-factor=3 \
 --config=exp/chain//tdnn_lstm1e_512_online/conf/online.conf \
 --min-active=200 --max-active=7000 --beam=15.0 \
 --lattice-beam=6.0 --acoustic-scale=1.0 \
 --word-symbol-table=exp/chain//tdnn_lstm1e_512/graph/words.txt \
 exp/chain//tdnn_lstm1e_512_online/final.mdl \
 exp/chain//tdnn_lstm1e_512/graph/HCLG.fst \
 ark:spk2utt.JOB "ark,s,cs:src/featbin/wav-copy --print-args=false scp,p:wav.JOB.scp ark:- |" \
 "ark:|src/latbin/lattice-scale --print-args=false --acoustic-scale=10.0 ark:- ark:- | gzip -c > lat.JOB.gz"

cat *.log > full.log
python GetResult.py
cp result.txt /opt/audio/
echo "识别结果（result.txt）已保存到测试音频文件夹"
