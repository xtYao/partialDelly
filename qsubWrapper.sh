#!/bin/bash -l
#$ -N jobName
#$ -j y
#$ -cwd
#$ -l h_vmem=12G
#$ -l os=rhel6.3
#$ -l zenodotus=true
#$ -m ea
#$ -M xiy2006@med.cornell.edu

srcDir=/zenodotus/dat01/khuranalab_store/xy293/program/partialDelly
dataDir=/zenodotus/sbonerlab/scratch/SoftTissues_MSKCC/asboner/58Samples/BAM

# start running
#cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch2_1to8Baca.txt | xargs -n 1 -P 4 ./runVerify.sh
#cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch3_9to16Baca.txt | xargs -n 1 -P 4 ./runVerify.sh
#cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch3_17to24Baca.txt | xargs -n 1 -P 4 ./runVerify.sh
#cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch3_25to32Baca.txt | xargs -n 1 -P 4 ./runVerify.sh
#cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch3_33to40Baca.txt | xargs -n 1 -P 4 ./runVerify.sh
#cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch3_41to48Baca.txt | xargs -n 1 -P 4 ./runVerify.sh
cat /zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify/batch3_49to56Baca.txt | xargs -n 1 -P 4 ./runVerify.sh

