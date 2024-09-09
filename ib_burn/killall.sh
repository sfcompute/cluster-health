#!/bin/bash
for i in {1..27}; do ssh -o StrictHostKeyChecking=no root@ibtest-$i "pkill -f ib_write_bw"; done
