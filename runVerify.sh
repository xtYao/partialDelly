#!/bin/bash -l
#$ -N jobName
#$ -j y
#$ -cwd
#$ -l h_vmem=4G
#$ -l os=rhel6.3
#$ -l zenodotus=true
#$ -m ea
#$ -M xy293@cornell.edu

# directory of BAMs
#dataDir=/zenodotus/dat01/khuranalab_scratch/alm2069/Data_Source/BAM_files/MMS22L_ARHGAP10_translocation_sample
dataDir=/zenodotus/sbonerlab/scratch/SoftTissues_MSKCC/asboner/58Samples/BAM
grch37=/home/xy293/refGnm/GRCh37-lite
echo "$(date): data location $dataDir"
echo "$(date): reference genome $grch37"
resultDir=/zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify
echo "$(date): result will be saved to $resultDir"

echo "$(date): copying data to working directory..."
rsync -av $dataDir/01-28*.bam $TMPDIR
rsync -av $grch37/* $TMPDIR
cd $TMPDIR
echo "$(date): copied data to working directory"

# running on whole chr 6 and 4, DEL, TRA, DUP, INV
for bam in $(find . -type f -name *.bam):
do
    echo "$(date) start processing $bam"
    $SGE_O_WORKDIR/partialDelly -t DEL -R *.fa -I '6 4' $bam
    $SGE_O_WORKDIR/partialDelly -t TRA -R *.fa -I '6 4' $bam
done

# compress result files and move back to result dir
tar -cvf $runName.result.tar *.target.sorted.bam* *.vcf
scp $runName.result.tar $resultDir
