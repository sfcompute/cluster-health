#!/bin/bash

# Read the inventory file
inventory_file="inventory.csv"

# Check if the inventory file exists
if [ ! -f "$inventory_file" ]; then
    echo "Error: Inventory file $inventory_file not found."
    exit 1
fi

# Function to copy and execute the script on a server
kill_process() {
    server=$1
    echo "Killing python processes on  $server"
    ssh -o StrictHostKeyChecking=no root@$server "pkill -9 python3" < /dev/null 
}

# Read each line from the inventory file and process it
while read server; do
    # Copy and execute the script on the server
    kill_process "$server" 
done < "$inventory_file"

# Wait for all background processes to finish
wait

echo "All python processes have been killed.."
