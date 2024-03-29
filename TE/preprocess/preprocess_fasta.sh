#!/bin/bash

cp /mnt/gluster/dgshrader/MergedReads-TroutBog/$1 ./

# add Python 2.7 to path, to use instead of system Python (old)
export PATH=$(pwd)/python/bin:$PATH
# unwrap fasta
python FastaMLtoSL.py $1

rm $1
mv $1.out $1

# make a folder for each metagenome
code=`echo "$1" | cut -d'.' -f1`
mkdir ${code}
split -l 140000 $1 ${code}/${code}


# create a read file list (for the mapping step)
python ./list_files.py ${code}
# move read file list to folder of the metagenome
mv readFileList.txt ${code}/



tar -zcvf ${code}.tar.gz ${code}/
rm -r ${code}
rm $1


### extra code for inspiration:

# DATA_DIRS=${fourletter}/
# for j in $DATA_DIRS; do
# DATA_FILES="$j"*
# for k in $DATA_FILES; do
# echo "${k:0:4} ${k:5:11}" >> readFileList.txt
# done
# done

# DATA_DIRS=${fourletter}/
#for k in $DATA_DIRS
# echo "${k:0:4} ${k:5:11}" >> readFileList_$1.txt
# done

# $Fn(read)/
# code = $Fn($1)
# mkdir ${code}
# split -l 140000 $1 ${code}/${code}
# echo "Two echo lines"
# echo $Fn($1)
# echo $Fn(1)
