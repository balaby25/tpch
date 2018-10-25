#!/usr/bin/python

import time
import os
import sys
import ConfigParser
import threading
import datetime
import subprocess

def adhoc():
    print "[INFO ]   adhoc  commands..so, be careful  "
    cmd="ansible-playbook -i hosts.ini -u ec2-user setupTPCH.yml  "
    #cmd="ansible-playbook -i hosts.ini setupTPCH.yml --tags \"for2GO\" "
    #cmd="ansible-playbook -i hosts.ini setupTPCH.yml --tags \"justThis\" "
    #cmd="ansible-playbook -i hosts.ini createTPCHSchema.yml   "
    os.system(cmd)

def justPing():
    print "[INFO ] only pinging the hosts ."
    cmd="ansible -i hosts.ini aws -u ec2-user -m ping"
    os.system(cmd)

def runSql():
    print "[INFO] running shardSqlinAll.yml play book "
    cmd="ansible-playbook -i hosts.ini runSql.yml"
    os.system(cmd)

if __name__ == "__main__":
    # by default do nothing
    op = "nothingToDo"
    if len(sys.argv) == 2:
        op = sys.argv[1]

    ts=datetime.datetime.now().strftime('%Y-%m-%d_%H:%M')

    if (op == "adhoc"):
        print "[INFO] ========== running adhoc comds   =========="
        adhoc()
    elif (op == "justPing"):
        print "[INFO] ========== pinging the hosts   =========="
        justPing()
    elif (op == "run-sql"):
        print "[INFO] ==========  running sql in all shards   =========="
        runSql()
    else:
        print "[ERROR] Unrecognized option (can be  \"justPing\" , \"adhoc\", \"run-sql\"   ): "+op 
