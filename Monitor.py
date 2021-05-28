import os
import tqdm
import subprocess


def GetProcessed(log_file):
    if not os.path.exists(log_file)
        return 0

    count = 0
    return count

if __name__ == '__main__':
    TotalNum = len(open("wav.scp",'r').readlines())
    JOB = int(open("JOB", 'r').readlines()[0])
    
    log_list = ["%i.log" % (i + 1) for i in range(JOB)]
    
    Processed = 0
    pbar = tqdm(total=TotalNum, desc = "Prcocessed Audio Files")
    while (Processed < TotalNum):
        new_count = 0
        for log in log_list:
            new_count += GetProcessed(log)
        
        if new_count > Processed:
            pbar.update(new_count - Processed)
            Processed = new_count

        

        


    