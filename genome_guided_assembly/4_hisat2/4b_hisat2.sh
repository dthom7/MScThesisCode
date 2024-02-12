#!/bin/bash

#SBATCH --time=4:00:00
#SBATCH --mem=24G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2/logs/4b_hisat2.%A_%a.out
#SBATCH --cpus-per-task=16
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=16

#### Load modules
module load hisat2/2.2.1
module load samtools/1.17

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly hisat2_index=/home/jd2thomp/projects/def-bkatzenb/jd2thomp/genomes/woodfrog_nuclear/hisat2_index/GCA_028564925.1_aRanSyl1.merge_genomic

#### Array handling
readonly R1_files=(${input_dir}/*.R1.fq.gz)
readonly R2_files=(${input_dir}/*.R2.fq.gz)
echo "R1_files length: ${#R1_files[@]}"
echo "R2_files length: ${#R2_files[@]}"

readonly R1=${R1_files[${SLURM_ARRAY_TASK_ID}]}
readonly R2=${R2_files[${SLURM_ARRAY_TASK_ID}]}
readonly sample_id_long=$(basename ${R1} .cor.trim.nonrrna.R1.fq.gz)
readonly sample_id=${sample_id_long%_*_*}
echo "R1 file: ${R1}"
echo "R2 file: ${R2}"
echo "sample id: ${sample_id}"

#### Output
readonly bam_output=${output_dir}/bam/${sample_id}.wf_nuc_align.bam
readonly summary_file=${output_dir}/alignment_summaries/${sample_id}.txt
readonly paired_aligned=${output_dir}/fastq/paired_aligned/${sample_id}.paired_aligned.fq.gz
readonly paired_unaligned=${output_dir}/fastq/paired_unaligned/${sample_id}.paired_unaligned.fq.gz
readonly unpaired_aligned=${output_dir}/fastq/unpaired_aligned/${sample_id}.unpaired_aligned.fq.gz
readonly unpaired_unaligned=${output_dir}/fastq/unpaired_unaligned/${sample_id}.unpaired_unaligned.fq.gz

#### Read Group Fields
readonly rg_id=HCVTNDSX3.4
readonly rg_pu=PU:${rg_id}.${sample_id}
readonly rg_sm=SM:${sample_id}
readonly rg_pl=PL:ILLUMINA
readonly rg_lb=LB:${sample_id}

#### Print version information
echo "#### HISAT2 VERSION ####"
echo "$(hisat2 --version)"
echo "####"
echo ""

echo "#### SAMTOOLS VERSION ####"
echo "$(samtools --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

hisat2 \
    -x ${hisat2_index} \
    -1 ${R1} \
    -2 ${R2} \
    -p ${nthreads} \
    --summary-file ${summary_file} \
    --rna-strandness RF \
    --rg-id ${rg_id} \
    --rg ${rg_sm} \
    --rg ${rg_lb} \
    --rg ${rg_pl} \
    --rg ${rg_pu} \
    --dta \
    --un-gz ${unpaired_unaligned} \
    --al-gz ${unpaired_aligned} \
    --un-conc-gz ${paired_unaligned} \
    --al-conc-gz ${paired_aligned} \
    | samtools view -u \
    | samtools sort -o ${bam_output}

echo "Completed with exit status ${?}"
