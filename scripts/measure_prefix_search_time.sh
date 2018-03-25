#! /bin/bash

echo "prefix_time" > cpy.txt
echo "prefix_time" > ref.txt

echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
./test_cpy < command.txt | grep -a 'searched prefix' | grep -Eo '[0-9]*\.[0-9]+' >> cpy.txt

echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
./test_ref < command.txt | grep -a 'searched prefix' | grep -Eo '[0-9]*\.[0-9]+' >> ref.txt
