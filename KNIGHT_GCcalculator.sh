#!/bin/bash 

# Setting up a confidence check to ensure there is a file on the command line to excute the script. If the script is run with a file (ex. ./KNIGHT_GCcalculator.sh example.fa) then the script will give "Executing GC Content for example.fa." If the script is run with no file chosen (ex. ./KNIGHT_GCcalculator.sh) then the script will give "ERROR: include fasta file name" and exit the script. This way the script cannot run without a file.

if [ $1 ]; then
    echo "Executing GC Content for $1"
else
    echo "ERROR: include fasta file name"
exit
fi

# Setting up another confidence check to ensure that the input file exists. Putting the simple [ -e $1 ] as a file test will check the directory that the script is running in. If the file does exist the script will read "File Exist" in the output and will continue in the script. If there is not file in the directory, the script will read "ERROR: file does not exist" and exit the script. This way the script runs with a file that is included in the command line that also exists in the directory.

if [ -e $1 ]; then
     echo "File Exists"
else
     echo "ERROR: file does not exist"
exit
fi

# Calculate the number of sequences in the input fasta file save this file as a variable. This is done by reading the lines that start with ">" in the file. This captures the lines of the different sequences. These lines are counted by the command wc -l. 

SEQNUM=`grep ">" $1 | wc -l`

# CORRECTION: In this step in my original submission, I forgot to create an empty file that creates GCcount.txt. This is done with the command touch.

touch GCcount.txt

# Redirect an empty file GCcount.txt with a printed header 1) "Sequence name" and 2) "GC Percentage." This is done by echoing the two column names side by side into a file that is created when running the script.  

echo "Sequence name  GC Percentage" > GCcount.txt

#Create two arrays for the for loop to create a way to run the different sequences in the file through different commands to find the different GC content. The HEADER array makes an array for the different names of the sequences which grep finds by looking at the lines with ">." The sequence array is an array for just the sequences which grep finds by looking at every line but the lines with ">." 

HEADER=($(grep ">" $1))
SEQUENCE=($(grep -v ">" $1))

#echo Sequence name: ${HEADER[0]}

# Set up a loop to iterate as many times as you have sequences to run. This will insure that that each sequence gets its own GC content percentage. The for loop will start with the first element (X=0) and continue until all the sequences have been run (X<$SEQ). It will start at the first element and continue until the last (X++). Within the commands the array that is called is ${SEQUENCE[$X]} so that only the individual sequences in the array are called one at a time until the loop is finished with the number of sequences. Individual "G" and "C" characters are saved in a variable through the command grep for each sequence. The total number of sequences is found by recalling the different elements of the array and counting the number of lines. 
for ((X=0; X<$SEQNUM; X++))
do

#	echo $X
     G=`echo ${SEQUENCE[$X]} | grep -o "G" | wc -l`
     C=`echo ${SEQUENCE[$X]} | grep -o "C" | wc -l`
     T=`echo ${SEQUENCE[$X]} | wc -m`
#	echo "Total: $T; G: $G; C: $C"
# The percentage of each GC content is found by scaling the problem to 3 and then adding $G and $C for each element of the array together. This number is then divided by the total number of characters for each different element of the array. To convert this into a percentage, the decimal is then multiplied by 100. The "bc" is the command line calculator to evaluate these different expressions.

     PERCENTAGE=`echo "scale=3; (($G+$C)/($T-1))*100" | bc`

# To allow the GCcount.txt to display all the sequence names and sequence GC percentages, the HEADER array with all the different elements from earlier is echoed into the same GCcount.txt file along with the different percentages that was made into a variable in this loop. These outputs overwrite the earlier file so that it displays the correct printed header and information from the loop.

echo "${HEADER[$X]}, $PERCENTAGE" >> GCcount.txt 


done

#exit

