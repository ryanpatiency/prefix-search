#! /bin/bash

echo "load_time" > cpy1.txt
echo "load_time" > ref1.txt

for ((i=1;i<=100;i++));
do
	#echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
	./test_cpy < command.txt | grep load | grep -Eo '[0-9]*\.[0-9]+' >> cpy1.txt
done

for ((i=1;i<=100;i++));
do
	#echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
	./test_ref < command.txt | grep load | grep -Eo '[0-9]*\.[0-9]+' >> ref1.txt
done