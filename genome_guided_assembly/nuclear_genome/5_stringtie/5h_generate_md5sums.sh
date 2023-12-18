#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/logs/5h_generate_md5sums.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie
readonly output_dir=${base_dir}/output
readonly merge_dir=${output_dir}/merge
readonly fasta_dir=${output_dir}/fasta

#### Run program
echo "Beginning run"

cd ${merge_dir}

for file in *
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${merge_dir}"

cd ${fasta_dir}

for file in *
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${fasta_dir}"

echo "Completed script"
