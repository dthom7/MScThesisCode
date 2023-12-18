#!/bin/bash

readonly source_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2/output/bam
readonly symlink_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/input

echo "Creating symlinks in directory: ${symlink_dir}"
echo "Source directory: ${source_dir}"

cd ${symlink_dir}

for bam in ${source_dir}/*.bam
do
    bam_link=$(basename ${bam})
    ln -s ${bam} ${bam_link}
    echo "Created ${bam_link} with exit status ${?}"
done

echo "Script complete"
