#!/bin/bash
if [ "$#" -ne 1 ];
then
	printf "Usage: ./test.sh <Number of test cases>\n"
	exit 1
fi

printf "Number of testcases = $1\n" 
if g++ -o generator generator.cpp;
then
	printf "\nGenerator compiled successfully.\n"
else
	printf "\nGenerator compilation failed.\n"
	exit 1
fi

cmd="./generator $1"
if timeout 30s $cmd;
then
	printf "\nGenerator executed successfully.\n"
else
	printf "\nGenerator execution failed due to timeout or runtime errors.\n"
	exit 1
fi

rm generator

if g++ -o solution solution.cpp;
then
	printf "\nOptimal solution compiled successfully.\n"
else
	printf "\nOptimal solution compilation failed.\n"
	exit 1
fi

touch testcases/input/input00.txt
touch testcases/output/output00.txt

for (( tno=0; tno<=$1; tno++ ))
do
	ifname="input"
	ofname="output"
	if(($tno < 10))
	then
		append=0
		ifname="$ifname$append"
		ofname="$ofname$append"
	fi
	ifname="$ifname$tno"
	ofname="$ofname$tno"
	ext=".txt"
	ifname="$ifname$ext"
	ofname="$ofname$ext"
	cat $tno > $ifname
	if timeout 30s ./solution<$ifname>$ofname;
	then
		printf ""
	else
		printf "\nOptimal solution execution failed due to timeout or runtime errors.\n"
		exit 1
	fi
	rm $tno
	mv $ifname testcases/input/
	mv $ofname testcases/output/
done

rm solution
zip -r testcases.zip testcases
