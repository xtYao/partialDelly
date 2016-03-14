#!/bin/bash -l
set -e
set -u
set -o pipefail

usage () {
echo "
Help message here.
"
}

# options, default
export runName="defaultRun"
export refGen="/home/xy293/refGnm/GRCh37-lite/GRCh37-lite.fa"
regionInterval="6:97585037-97736052 4:148648453-148998927"
svType="TRA"
# regionBed=${srcDir}/chr19.bed

# show help msg if no arg given
if test "$#" -lt 1
then
    usage
    exit 0
fi

# optional args
while [[ $1 == -* ]]
do
    case "$1" in
    --reference | -R)
        if [[ $2 == -* ]]
        then
	usage
	exit 1
        else
	export refGen=$2
        fi
        shift; shift;
        ;;
#    --regionBed | -B)
#        if [[ $2 == -* ]]
#        then
#	usage
#	exit 1
#        else
#	regionBed=$2
#        fi
#        shift; shift;
#        ;;
    --outBasename | -o)
        if [[ $2 == -* ]]
        then
	usage
	exit 1
        else
	runName=$2
        fi
        shift; shift;
        ;;
    --svType | -t)
	if [[ $2 == -* ]]
        then
        usage
        exit 1
        else
        svType=$2
        fi
        shift; shift;
        ;;
    --help | -h)
        usage
        exit 0
        shift
        ;;
    esac
done

bam=$1

# extract the targeted regions
samtools view -h $bam $regionInterval | samtools sort -o $TMPDIR/$runName.sortedRegional.bam
samtools index $TMPDIR/$runName.sortedRegional.bam

# run delly in the given mode
delly -t $svType -o $runName.$svType.regional.vcf -g $refGen $TMPDIR/$runName.sortedRegional.bam
scp $runName.$svType.regional.vcf $SCRATCH/MMS22L_ARHGAP10_traVerify
scp $runName.$svType.regional.vcf /zenodotus/dat01/khuranalab_scratch/alm2069/Data_Source/BAM_files/MMS22L_ARHGAP10_translocation_sample/verifyTraResult
