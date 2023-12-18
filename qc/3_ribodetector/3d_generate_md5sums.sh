#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector/logs/3d_generate_md5sums.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector
readonly nonrrna_dir=${base_dir}/output/rrna_removed
readonly rrna_dir=${base_dir}/output/rrna

#### Run program
echo "Beginning run"

cd ${nonrrna_dir}

for file in *.fq.gz
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${nonrrna_dir}"

cd ${rrna_dir}

for file in *.fq.gz
do
    md5sum ${file} > ${file}.md5
    echo "${file} exit status: ${?}"
done

echo "#### Done generating md5sums in ${rrna_dir}"

echo "Completed script"
