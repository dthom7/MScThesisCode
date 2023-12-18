#!/bin/bash

readonly source_dir=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector/output/rrna_removed
readonly symlink_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2/input

echo "Creating symlinks in directory: ${symlink_dir}"
echo "Source directory: ${source_dir}"

cd ${symlink_dir}

for fq in ${source_dir}/*.fq.gz
do
    fq_link=$(basename ${fq})
    ln -s ${fq} ${fq_link}
    echo "Created ${fq_link} with exit status ${?}"
done

echo "Script complete"
