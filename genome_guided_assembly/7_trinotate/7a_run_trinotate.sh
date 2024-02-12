#!/bin/bash

#SBATCH --time=4-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=28G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/7_trinotate/logs/7a_run_trinotate.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=48

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
readonly transdecoder_pep=${input_dir}/merged.wf_nuc_align.fa.transdecoder.pep
readonly gene_trans_map=${input_dir}/merged.wf_nuc_align.gene_transcript_map.tsv
readonly transcript_fasta=${input_dir}/merged.wf_nuc_align.fa

#### Other
readonly trinotate_db=${output_dir}/trinotate_db.sqlite
export TRINOTATE_HOME=/home/jd2thomp/programs/Trinotate-Trinotate-v4.0.1
export TRINOTATE_DATA_DIR=/project/6075059/jd2thomp/trinotate_data

#### Run program
echo "Beginning run"

cd ${working_dir}

cp ${TRINOTATE_DATA_DIR}/TrinotateBoilerplate.sqlite ${trinotate_db}

${TRINOTATE_HOME}/Trinotate \
    --db ${trinotate_db} \
    --init \
    --gene_trans_map ${gene_trans_map} \
    --transcript_fasta ${transcript_fasta} \
    --transdecoder_pep ${transdecoder_pep}

echo "Database initialization completed with exit status ${?}"

${TRINOTATE_HOME}/Trinotate \
    --db ${trinotate_db} \
    --CPU ${nthreads} \
    --transcript_fasta ${transcript_fasta} \
    --transdecoder_pep ${transdecoder_pep} \
    --trinotate_data_dir ${TRINOTATE_DATA_DIR} \
    --run ALL

echo "Completed with exit status ${?}"
