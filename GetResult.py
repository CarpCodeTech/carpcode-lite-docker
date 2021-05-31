##This code is to prepare audio for pure kaldi prototype, it assumes audios are in wav format
""" Command-line usage:
      python GetResult.py
"""
import os
import re
import shutil
from sys import exit
import sys
import getopt
import subprocess

def GetRestult(lines, name_keep=True):
    result = {}
    for index in range(len(lines)):
        if "Decoded utterance" in lines[index]:
            parts = lines[index - 1].strip().split()
            if name_keep:
                name = "_".join(parts[0].split("_")[:])
            else:
                name = "_".join(parts[0].split("_")[2:])
            result[name] = " ".join(parts[1:])
    return result

if __name__ == '__main__':
    try:
        
        lines = open("full.log", "r").readlines()
        result = GetRestult(lines)
        
        output = open("result.txt", "w")
        key_list = list(result.keys())
        key_list.sort()
        for key in key_list:
            output.write("%s %s\n"%(key, result[key]))        
        output.close()

        
    except :
        print(__doc__)
        (type, value, traceback) = sys.exc_info()
        print(sys.exc_info())
        sys.exit(0)