#!/usr/bin/env bash
#
#  Run IOR until it can run no more, writing 10 GiB files at a time
#

IOR=${IOR:-/home/glock/src/git/ior/src/ior}
LOG_DIR=${LOG_DIR:-$HOME}
TEST_DIR=${TEST_DIR:-/mnt/nvme0n1}

NPROC=16
BSIZE=4096
SEGCT=8192
# reminder: total data volume = NPROC * SEGCT * BSIZE

iter=0
set -e
while /bin/true
do
    token=$RANDOM
    logfile="${LOG_DIR}/ior_${iter}.log"
    echo "Running IOR - $token" > $logfile
    mpirun -n $NPROC -bind-to core $IOR -t $BSIZE -b $BSIZE -s $SEGCT -v -B -a POSIX -w -k -o "${TEST_DIR}/tmp${token}" -z >> "$logfile" 2>&1
    iter=$((iter + 1))
done
