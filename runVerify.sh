#!/bin/bash -l
#$ -N jobName
#$ -j y
#$ -cwd
#$ -l h_vmem=4G
#$ -l os=rhel6.3
#$ -l zenodotus=true
#$ -m ea
#$ -M xy293@cornell.edu

#rsync -av $SGE_O_WORKDIR/* $TMPDIR
#touch $SGE_O_WORKDIR/result
#cp -v $TMPDIR/result $SGE_O_WORKDIR

#dataDir=/zenodotus/dat01/khuranalab_scratch/alm2069/Data_Source/BAM_files/MMS22L_ARHGAP10_translocation_sample
dataDir=/zenodotus/sbonerlab/scratch/SoftTissues_MSKCC/asboner/58Samples/BAM
cd $dataDir
for file in $(find . -type f -name *.bam):
do
    $SCRATCH/MMS22L_ARHGAP10_traVerify/verifyTra_MMS22L.sh -o $(basename $file) $file
done
