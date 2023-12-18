#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH --mem=10G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp/logs/2g_generate_md5sums.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp
readonly paired_dir=${base_dir}/output/paired
readonly unpaired_dir=${base_dir}/output/unpaired

#### Run program
echo "Beginning run"

cd ${paired_dir}

for file in *.fq.gz
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${paired_dir}"

cd ${unpaired_dir}

for file in *.fq.gz
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${unpaired_dir}"

echo "Completed script"
