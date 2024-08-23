#!/bin/bash

# Read the inventory file
inventory_file="inventory.csv"

# Check if the inventory file exists
if [ ! -f "$inventory_file" ]; then
    echo "Error: Inventory file $inventory_file not found."
    exit 1
fi

# Check if the GPU stress test script exists
if [ ! -f "gpu_stress_test.py" ]; then
    echo "Error: GPU stress test script gpu_stress_test.sh not found in the current directory."
    exit 1
fi

# Function to copy and execute the script on a server
copy_and_execute() {
    server=$1
    echo "Copying and executing on $server"
    scp -o StrictHostKeyChecking=no gpu_stress_test.py root@$server:/root/
    ssh -o StrictHostKeyChecking=no root@$server "python3 /root/gpu_stress_test.py 345600 &" < /dev/null &
}

# Read each line from the inventory file and process it
while read server; do
    # Copy and execute the script on the server
    copy_and_execute "$server" 
done < "$inventory_file"

# Wait for all background processes to finish
wait

echo "All stress tests have been initiated and completed."
