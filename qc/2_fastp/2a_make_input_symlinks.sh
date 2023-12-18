#!/bin/bash

readonly source_dir=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector/output/unfixable_removed
readonly symlink_dir=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp/input

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
