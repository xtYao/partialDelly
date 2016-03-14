newBamName=$(basename $1 | sed 's/.bam/target.sorted.bam/')
regionInterval=$2

if [ ! -f ./$newBamName ]
then
    echo "$(date): extracting reads from BAM, in the region $regionInterval"
    samtools view -h $bam "$regionInterval" | samtools sort -o ./$newBamName
    samtools index ./$newBamName
else
    echo "$(date): file exists, continue to the next step"
fi
