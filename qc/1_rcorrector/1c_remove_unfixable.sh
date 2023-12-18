#!/bin/bash

#SBATCH --time=16:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector/logs/1c_remove_unfixable.%A_%a.out
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load python/2.7.18

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector
readonly input_dir=${base_dir}/output
readonly output_dir=${input_dir}/unfixable_removed

#### Input
cd ${input_dir}
readonly R1_files=([WG]*_R1_001.cor.fq.gz)
readonly R2_files=([WG]*_R2_001.cor.fq.gz)

#### Array handling
echo "R1_files length: ${#R1_files[@]}"
echo "R2_files length: ${#R2_files[@]}"

readonly R1=${R1_files[${SLURM_ARRAY_TASK_ID}]}
readonly R2=${R2_files[${SLURM_ARRAY_TASK_ID}]}
readonly sample_id=$(basename ${R1} _R1_001.cor.fq.gz)
echo "R1 file: ${R1}"
echo "R2 file: ${R2}"
echo "sample id: ${sample_id}"

#### Print version information
echo "#### PYTHON VERSION ####"
echo "$(python --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${input_dir}

python /home/jd2thomp/programs/TranscriptomeAssemblyTools/FilterUncorrectabledPEfastq.py \
    -1 ${R1} \
    -2 ${R2} \
    -s ${sample_id}

echo "Filtering complete with exit status ${?}"

readonly R1_filtered=unfixrm_$(basename ${R1} .gz)
echo "gzipping filtered left reads file ${R1_filtered}"
gzip ${R1_filtered}
echo "gzip completed with exit status ${?}"
echo "calculating filtered left read md5"
md5sum ${R1_filtered}.gz > ${R1_filtered}.gz.md5
echo "md5 completed with exit status ${?}"

readonly R2_filtered=unfixrm_$(basename ${R2} .gz)
echo "gzipping filtered right reads file ${R2_filtered}"
gzip ${R2_filtered}
echo "gzip completed with exit status ${?}"
echo "calculating filtered right read md5"
md5sum ${R2_filtered}.gz > ${R2_filtered}.gz.md5
echo "md5 completed with exit status ${?}"

cd ${output_dir}

mv ../${R1_filtered}.gz .
echo "left fq moved with exit status ${?}"
mv ../${R1_filtered}.gz.md5 .
echo "left md5 moved with exit status ${?}"
md5sum -c ${R1_filtered}.gz.md5
echo "left md5sum check completed with exit status ${?}"

mv ../${R2_filtered}.gz .
echo "right fq moved with exit status ${?}"
mv ../${R2_filtered}.gz.md5 .
echo "right md5 moved with exit status ${?}"
md5sum -c ${R2_filtered}.gz.md5
echo "right md5sum check completed with exit status ${?}"

echo "Script complete"
