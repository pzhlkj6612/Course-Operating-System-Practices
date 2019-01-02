#! /bin/bash


workSpace=$(pwd)
folderName=Kimi_no_Na_wa
file1Name=file1
file2Name=file2


function Cycle(){
	while true
	do
		DrawMenu
		InputProc
	done
}


function InputProc(){
	echo -n "Enter your choice: "
	read input

	case $input in
		'A'|'a')
			c_A
			EndProc
			;;
		'B'|'b')
			c_B
			EndProc
			;;
		'C'|'c')
			c_C
			EndProc
			;;
		'D'|'d')
			c_D
			EndProc
			;;
		'E'|'e')
			c_E
			EndProc
			;;
		'Q'|'q')
			c_Q
			EndProc
			;;
		*)
			echo 'Try again!'
			read
	esac
}


function EndProc(){
	echo
	echo
	echo -n "Press Enter to continue..."
	read
}


function InitKeyFiles(){
	touch ~/$file1Name
	man man | head -n 10 > ~/$file1Name

	touch ~/$file2Name
	man ls | head -n 10 > ~/$file2Name
}


file_list_command='find /etc/ -maxdepth 1 -type f'
declare -i file_count=$($file_list_command | wc -l)


function c_A(){
	echo
	echo
	echo " ****** Create subfolder and copy files ******"
	echo

	declare -i folderExistedFlag=$(find ~ -type d -name "$folderName" | wc -l)
	if [ $folderExistedFlag -eq 0 ]
		then
			mkdir ~/$folderName
	fi

	chmod 755 ~/$folderName

	cp ~/$file1Name ~/$folderName/
	cp ~/$file2Name ~/$folderName/

	echo "Content of \"$file1Name\" in folder \"~/$folderName/\":"
	cat ~/$folderName/$file1Name

	echo
	echo "Content of \"$file2Name\" in folder \"~/$folderName/\":"
	cat ~/$folderName/$file2Name

	:>~/$folderName/$file1Name
	:>~/$folderName/$file2Name

	echo "Content of \"$file1Name\" in folder \"~/$folderName/\":"
	cat ~/$folderName/$file1Name

	echo
	echo "Content of \"$file2Name\" in folder \"~/$folderName/\":"
	cat ~/$folderName/$file2Name

	#Clear
	rm ~/$folderName/$file1Name
	rm ~/$folderName/$file2Name
	if [ $folderExistedFlag -eq 0 ]
		then
			rm -rdf ~/$folderName
	fi
}


function c_B(){
	echo
	echo
	echo " ****** Permission test randomly******"
	echo

	declare -i file_index=$(expr $(echo "$RANDOM % ( $file_count - 1 ) + 1"))
	foundFilePath=$($file_list_command | head -n $file_index | tail -n 1)
#	ls -l $foundFilePath | grep 'rwx......' 1>/dev/null
#	if [ $? -eq 1 ]
#		then
#			echo "I don't have \"rwx\" permission with \"$foundFilePath\"."
#		else
#			echo "I have \"rwx\" permission with \"$foundFilePath!\"."
#	fi
	test -r $foundFilePath
	if [ $? -eq 0 ]
		then
			echo "Readable with $foundFilePath"
		else
			echo "Unreadable with $foundFilePath"
	fi
	test -w $foundFilePath
	if [ $? -eq 0 ]
		then
			echo "Writable with $foundFilePath"
		else
			echo "Unwritable with $foundFilePath"
	fi
	test -x $foundFilePath
	if [ $? -eq 0 ]
		then
			echo "Executable with $foundFilePath"
		else
			echo "Unexecutable with $foundFilePath"
	fi
}


function c_C(){
	file1Name_New=file1_new
	file2Name_New=file2_new

	echo
	echo
	echo " ****** Characters convert ******"
	echo
	echo "Translated content of \"file1\":"
	cat ~/$file1Name | tr '[a-z]' '[A-Z]' > $workSpace/$file1Name_New && cat $workSpace/$file1Name_New

	echo
	echo
	echo "Translated content of \"file2\":"
	cat ~/$file2Name | tr '[a-z]' '[A-Z]' > $workSpace/$file2Name_New && cat $workSpace/$file2Name_New

	# Clear
	rm $workSpace/$file1Name_New
	rm $workSpace/$file2Name_New
}


function c_D(){
	echo
	echo
	echo " ****** Do counting & show env ******"
	echo
	echo "Count of folders in \"/dev/\": $(ls -l /dev/ | grep '^d.*' | wc -l)"
	echo "Count of symbolic link files in \"/dev/\": $(ls -l /dev/ | grep '^l.*' | wc -l)"

	declare -i file_index=$(expr $(echo "$RANDOM % ( $file_count - 1 ) + 1"))
	foundFilePath=$($file_list_command | head -n $file_index | tail -n 1)
	echo
	echo "Count of empty lines in \"$foundFilePath\": $(cat $foundFilePath | grep '^$' | wc -l)"

	echo
	echo "All environment variables here:"
	env
}


function c_E(){
	echo
	echo
	echo " ****** Find something ******"
	echo
	find '/dev/' -name 's????' -exec 'file' {} \;
}


function DrawMenu(){
	clear
	echo -e $"\t\tUSER: $(whoami)\tHOST: $(hostname)\tDATE: $(date)"
	echo -e $"\t\t--------------------------------------------------------------------"
	echo
	echo -e $"\t\t\tA. Create subfolder and copy files"
	echo -e $"\t\t\tB. Permission test randomly"
	echo -e $"\t\t\tC. Characters convert"
	echo -e $"\t\t\tD. Do counting & show env"
	echo -e $"\t\t\tE. Find something"
	echo -e $"\t\t\tQ. Say goodbye"
	echo
	echo -e $"\t\t--------------------------------------------------------------------"
	echo
}


function c_Q(){
	#Clear
	rm ~/$file1Name
	rm ~/$file2Name
#	rm -rdf ~/$folderName
	
	clear
	echo "Goodbye!"
	echo
	exit
}


#public static int mian(){
	InitKeyFiles
	Cycle
#}

