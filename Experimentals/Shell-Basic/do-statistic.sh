#! /bin/bash


#Do you know shell array?
#Array=('a' 'b' 'c')
#echo ${Array[0]}


inFile='pc.txt'

if [ ! -e $inFile ]
	then
		echo 'student1:1301:75'  > $inFile 
		echo 'Student2:1302:96' >> $inFile
		echo 'Student3:1303:99' >> $inFile
		echo 'Student4:1302:93' >> $inFile
		echo 'Student5:1303:23' >> $inFile
		echo 'Student6:1301:77' >> $inFile
fi


declare -i isGood=85

declare -i Class1301=0
declare -i Class1302=0
declare -i Class1303=0

declare -i Class1301_Good=0
declare -i Class1302_Good=0
declare -i Class1303_Good=0

for line in $(cat $inFile)
	do
		var1=$(echo "$line" | awk -F ':' '{print $2}')
		declare -i var2=$(echo "$line" | awk -F ':' '{print $3}')

		case $var1 in
			'1301')
				Class1301=$Class1301+1
				if [ $var2 -gt $isGood ]
					then
						Class1301_Good=$Class1301_Good+1
				fi
				;;
			'1302')
				Class1302=$Class1302+1
				if [ $var2 -gt $isGood ]
					then
						Class1302_Good=$Class1302_Good+1
				fi
				;;
			'1303')
				Class1303=$Class1303+1
				if [ $var2 -gt $isGood ]
					then
						Class1303_Good=$Class1303_Good+1
				fi
				;;
		esac
	done

if [ $Class1301 -ne 0 ]
	then
		Class1301_RATIO=$(echo "$Class1301_Good/$Class1301" | bc -l)
fi
if [ $Class1302 -ne 0 ]
	then
		Class1302_RATIO=$(echo "$Class1302_Good/$Class1302" | bc -l)
fi
if [ $Class1303 -ne 0 ]
	then
		Class1303_RATIO=$(echo "$Class1303_Good/$Class1303" | bc -l)
fi

echo "Class 1301: $Class1301, excellence rate: $Class1301_RATIO"
echo "Class 1302: $Class1302, excellence rate: $Class1302_RATIO"
echo "Class 1303: $Class1303, excellence rate: $Class1303_RATIO"



rm $inFile
