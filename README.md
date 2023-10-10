# KNIGHT_Project_2
## Synopsis
With this script, a file is read and the GC percentage of the sequences within it are echoed into a text file.  A file must be included on the command line when running the script so that specific file is read. This is because the script is not hard coded to a specific file. Whichever file that needs the GC content to be found is run on the command line so the user can output that specific files percentages. This is done by confidence check in the beginning of the scripts and a for loop created for each sequence in a specific file.
## Code Example/Results
For the confidence checks in the beginning of the script, a condition is provided and the outcomes determine whether the scripts continue or not. Here is an example that is included in the script
```ruby
if [ $1 ]; then
    echo "Executing GC Content for $1"
else
    echo "ERROR: include fasta file name"
exit
fi
```
As you can see, if there is no file on the command line with the script, there is an error and the script is exited. If there is a file included, there is an echo of confirmation and the script continues. This is done again to make sure the file exists. 
To continue with the script before the for loop, some variables and arrays have to be created. The number of sequences in the file have to be found with grep and is saved as a variable. An array for both the sequence name and sequence itself is also created so it can be used in the loop. This array example can be shown below:
```ruby
HEADER=($(grep ">" $1))
```
This allows the for loop to be run through all of the sequences instead of the file being read one single sequence. The foor loop is set up with the condition of starting at the first element of the array (0) and running through the sequences until less than the number of sequences (the variable created earlier) is reached (because the first element is 0). These condtions can be shown below:
```ruby
for ((X=0; X<$SEQNUM; X++))
do
```
To find the number of "G" and "C" in the sequence, commands are then written in (grep and wc -l) to find how many times these characters occur. The percentage is found from taking each variable of "G" and "C" adding the two together before dividing the sum by the total. This is then multiplied by 100 to find the percentage. To print each sequence name and percentage on a file, the command echo is used for each sequence of the loop. To create a printed header, an echo for the title of the header needed is included earlier in the script outside of the loop. 
### Table of GC Content Example (ADH.fa)
An example of the result from printing the percentages and sequence names from the loop and the printed header from earlier in the script should look something like this when redirected into the file GCcount.txt:

| SEQUENCE NAME | GC PERCENTAGE |
|---------------|---------------|
| >DI245396.1 | 43.600 |
| >DI245395.1 | 42.500 |
| >HW262829.1 | 43.600 |
| >546218138 | 42.500 |
| >X13802.1 | 39.100 |
| >NM_001179558.3 | 51.500 |
| >NM_001178613.2 | 45.300 |
| >AY558240.1 | 51.500 |
| >AB052924.1 | 51.500 |
These values that are produced in the script do not round as there was no command I found that has been taught in BIOL 5800 to round like a calculator would automatically do. This is a fault that I found in this particular GC calculator that I was trying to create.
## Motivation
The motivation for creating this calculator is to read any file (in fasta format) and calculate the GC percentages of each sequence in that file. This allows for extremely large sequence files to be analyzed. GC content is important to analyze in research because of the hydrogen bond content and its effect on a DNA sequence. Different characteristics arise from the different GC content (ex. denaturing temperature). 
