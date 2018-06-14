#!/bin/bash

declare -a names
declare -a lastNum
names[0]=""
lastNum[0]=0
numOfFile=0
#interactive=" -i"

myecho (){
	#echo $*
	#:
	echo -n "."
}

findNameArrayIdx(){
	local key="$1"
	myecho "search key $key" >&2
	local loop=1
	#while [ $loop -le $numOfFile ]
	for ((loop=1; loop<=${numOfFile}; loop++))
	do
		myecho "  compare ${names[${loop}]} and $key" >&2
		if [ "${names[${loop}]}" == "$key" ]; then
			echo "$loop" # return value
			break
		fi
		#loop=$(expr $loop + 1)
	done
}

dumpArray(){
	echo ""
	echo "There are ${numOfFile} to process"
	local loop=1
	#while [ $loop -le $numOfFile ]
	for ((loop=1; loop<=${numOfFile}; loop++))
	do
		echo "idx=${loop}, name: ${names[${loop}]}, count= ${lastNum[${loop}]}"
		#loop=$(expr $loop + 1)
	done
}

KeepLastFile(){
	local idx=$1
	local check
	local prefix=${names[${idx}]}
	local num=${lastNum[${idx}]}

	echo -e "\nStarting to process below files: "
	ls "${prefix}-"*.md
	read -p "mv \"${prefix}-${num}.md\" \"${prefix}.md\", OK? (y/n) " check
	if [ "$check" == "y" ]; then
		#echo "You say ok"
		mv "${prefix}-${num}.md" "${prefix}.md"
		read -p "rm \"${prefix}-\"*.md, OK? (y/n) " check
		if [ "$check" == "y" ]; then
			#echo "You say ok"
			rm ${interactive} "${prefix}-"*.md
		else
			echo "You say no"
		fi
	else
		echo "You say no"
	fi
}

cleanMD(){
	local loop=1
	#while [ $loop -le $numOfFile ]
	for ((loop=1; loop<=${numOfFile}; loop++))
	do
		KeepLastFile $loop
		#loop=$(expr $loop + 1)
	done

}

# scan files and get max number of each file
echo "Scaning files"
for file in *-*.md
do
	if [ "$file" == '*-*.md' ]; then
		continue
	fi
	myecho ""
	myecho "found file: ${file}"
	prefix=${file%-*\.md}
	num=${file##${prefix}-}
	num=${num%%\.md}
	myecho "Prefix: ${prefix}, num=${num}"
	idx=$(findNameArrayIdx "${prefix}")
	if [ "$idx" == "" ]; then
		numOfFile=$(expr $numOfFile + 1)
		idx=${numOfFile}
		names[${idx}]="$prefix"
		lastNum[${idx}]=$num
	else
		myecho "idx=$idx, num=$num"
		if [ ${lastNum[${idx}]} -lt $num ]; then
			lastNum[${idx}]=$num
		fi
	fi
	myecho "idx is ${idx}, lastNum is ${lastNum[${idx}]}"

	#if [ $numOfFile -eq 2 ]; then
	#	break;
	#fi
	
done


myecho "done----"

dumpArray

cleanMD

