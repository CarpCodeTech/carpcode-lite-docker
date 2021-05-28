#!/bin/bash

python PrepareAudio.py /opt/audio wav.scp spk2utt

src/online2bin/online2-wav-nnet3-latgen-faster --do-endpointing=false --print-args=false --verbose=-1 --frames-per-chunk=20 --extra-left-context-initial=0 --online=true --frame-subsampling-factor=3 --config=exp/chain//tdnn_lstm1e_512_online/conf/online.conf --min-active=200 --max-active=7000 --beam=15.0 --lattice-beam=6.0 --acoustic-scale=1.0 --word-symbol-table=exp/chain//tdnn_lstm1e_512/graph/words.txt exp/chain//tdnn_lstm1e_512_online/final.mdl exp/chain//tdnn_lstm1e_512/graph/HCLG.fst ark:spk2utt "ark,s,cs:src/featbin/wav-copy --print-args=false scp,p:wav.scp ark:- |" "ark:|src/latbin/lattice-best-path --acoustic-scale=10.0  --print-args=false ark:- \"ark,t:|egs/wsj/s5/utils/int2sym.pl -f 2- exp/chain/tdnn_lstm1e_512/graph/words.txt > result\" ark,t:ali" &> log

cat result