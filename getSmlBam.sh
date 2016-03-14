newBamName=$(basename $1 | sed 's/.bam/target.sorted.bam/')
samtools view -h $1 "6 4" | samtools sort -o $newBamName
samtools index $newBamName
