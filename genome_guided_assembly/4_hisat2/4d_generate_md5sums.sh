#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2/logs/4d_generate_md5sums.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2
readonly output_dir=${base_dir}/output
readonly bam_dir=${output_dir}/bam
readonly fastq_dir=${output_dir}/fastq

#### Run program
echo "Beginning run"

cd ${bam_dir}

for file in *.bam
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${bam_dir}"

cd ${fastq_dir}

for file in */*.gz
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${fastq_dir}"

echo "Completed script"
