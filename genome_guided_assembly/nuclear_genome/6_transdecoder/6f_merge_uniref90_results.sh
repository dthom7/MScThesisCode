#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/logs/6f_merge_uniref90_results.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder
readonly output_dir=${base_dir}/output
readonly input_dir=${output_dir}/split_uniref90_results

#### Input
readonly in_prefix=${input_dir}/uniref90_search.outfmt6

#### Output
readonly output_file=${output_dir}/uniref90_search.outfmt6

#### Run program
echo "Beginning run"

cd ${base_dir}

for i in {1..1000}
do
    echo ${i}
    cat ${in_prefix}.${i} >> ${output_file}
done

echo "Run complete with exit status ${?}"
