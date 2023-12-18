#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/logs/5c_stringtie_merge.%j.log
#SBATCH --cpus-per-task=8

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=8

#### Load modules
module load stringtie/2.2.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie
readonly input_dir=${base_dir}/output/per_sample_gtfs
readonly output_dir=${base_dir}/output/merge

#### Input
readonly input_file=${base_dir}/gtfs_to_merge.txt

#### Output
readonly output_file=${output_dir}/merged.wf_nuc_align.gtf

#### Print version information
echo "#### VERSION ####"
echo "$(stringtie --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

ls -1 ${input_dir}/*.gtf > ${input_file}

stringtie \
    --rf \
    -p ${nthreads} \
    --merge \
    -o ${output_file} \
    ${input_file}

echo "Completed with exit status ${?}"
