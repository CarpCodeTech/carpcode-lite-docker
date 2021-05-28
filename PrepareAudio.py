##This code is to prepare audio for pure kaldi prototype, it assumes audios are in wav format
""" Command-line usage:
      python PrepareAudio.py Audio_folder wav_rspecifier spk2utt_rspecifier
"""
import os
import re
import shutil
from sys import exit
import sys
import getopt
import subprocess
if __name__ == '__main__':
    try:
        opts, args = getopt.getopt(sys.argv[1:], "", [""])
        scp_dict = {}
        if len(args) != 3 :
            raise ValueError("Please varify your input")
        Audio_folder=args[0]
        wav_rspecifier=args[1]
        spk2utt_rspecifier=args[2]
        wav_scp=open(wav_rspecifier,"w")
        spk2utt_file=open(spk2utt_rspecifier,"w")
        index=0
        for dirpath, dirnames, filenames in os.walk(Audio_folder):
            for file in filenames:
                if "wav" in file:
                    index+=1
                    utt_name=file.replace(".wav","").strip()
                    transfer_line="sox %s --bits 16 -e signed -r 16k -c 1 -t wav - |"%os.path.join(dirpath,file)
                    scp_dict[utt_name] = transfer_line
                    
        
        utt_name_list = list(scp_dict.keys())
        utt_name_list.sort()
        for utt_name in utt_name_list:
            wav_scp.write("%s %s\n"%(utt_name, scp_dict[utt_name]))
            spk2utt_file.write("%s %s\n"%(utt_name, utt_name))

        wav_scp.close()
        spk2utt_file.close()
    except :
        print(__doc__)
        (type, value, traceback) = sys.exc_info()
        print(sys.exc_info())
        sys.exit(0)