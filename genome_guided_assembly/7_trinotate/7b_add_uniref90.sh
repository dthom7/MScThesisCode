#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/7_trinotate/logs/7b_add_uniref90.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Load modules
module load perl/5.30.2
module load sqlite/3.38.5
module load python/3.10.2
source ~/python_venvs/py3.10.2_annotation_venv/bin/activate
module load gcc/9.3.0 # required for transdecoder and blast+
module load blast+/2.14.0
module load transdecoder/5.7.1
module load hmmer/3.3.2
module load infernal/1.1.4
module load tmhmm/2.0c

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/7_trinotate
readonly output_dir=${base_dir}/output
readonly working_dir=${base_dir}/working_dir
readonly input_dir=${base_dir}/input_from_graham

#### Input
readonly blast_db_name=UniRef90
readonly blastp_result=${input_dir}/uniref90_search_peptides.outfmt6
readonly blastx_result=${input_dir}/uniref90_search_transcripts.outfmt6

#### Other
readonly trinotate_db=${output_dir}/trinotate_db.sqlite
export TRINOTATE_HOME=/home/jd2thomp/programs/Trinotate-Trinotate-v4.0.1
export TRINOTATE_DATA_DIR=/project/6075059/jd2thomp/trinotate_data

#### Run program
echo "Beginning run"

cd ${working_dir}

${TRINOTATE_HOME}/Trinotate \
    --db ${trinotate_db} \
    --LOAD_custom_blast ${blastp_result} \
    --blast_type blastp \
    --custom_db_name ${blast_db_name}

echo "Blastp results loaded with exit status ${?}"

${TRINOTATE_HOME}/Trinotate \
    --db ${trinotate_db} \
    --LOAD_custom_blast ${blastx_result} \
    --blast_type blastx \
    --custom_db_name ${blast_db_name}

echo "Blastx results loaded with exit status ${?}"
