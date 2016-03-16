runName=$1
echo "$(date): start analyzing sample $runName"
# directory of BAMs
#dataDir=/zenodotus/dat01/khuranalab_scratch/alm2069/Data_Source/BAM_files/MMS22L_ARHGAP10_translocation_sample
dataDir=/zenodotus/sbonerlab/scratch/SoftTissues_MSKCC/asboner/58Samples/BAM
grch37=/home/xy293/refGnm/GRCh37-lite
echo "$(date): data location $dataDir"
echo "$(date): reference genome $grch37"
resultDir=/zenodotus/dat01/khuranalab_scratch/xy293/MMS22L_ARHGAP10_traVerify
echo "$(date): result will be saved to $resultDir"

echo "$(date): copying data to working directory..."
rsync -av $dataDir/$runName*.bam* $TMPDIR
rsync -av $grch37/* $TMPDIR
cd $TMPDIR
echo "$(date): copied data to working directory"

# running on whole chr 6 and 4, DEL, TRA, DUP, INV
for bam in *.bam
do
    echo "$(date) start processing $bam"
    $SGE_O_WORKDIR/partialDelly.sh -t DEL -R *.fa -I '6 4:148648453-148998927' $bam
    $SGE_O_WORKDIR/partialDelly.sh -t TRA -R *.fa -I '6 4:148648453-148998927' $bam &
    $SGE_O_WORKDIR/partialDelly.sh -t INV -R *.fa -I '6 4:148648453-148998927' $bam &
    $SGE_O_WORKDIR/partialDelly.sh -t DUP -R *.fa -I '6 4:148648453-148998927' $bam
done

# compress result files and move back to result dir
tar -cvf $runName.result.tar *$runName*.target.sorted.bam* *$runName*.vcf
scp $runName.result.tar $resultDir
