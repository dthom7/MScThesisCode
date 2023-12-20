# 16_all_sample_heatmap.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

all_sample_heatmap <- function(dds_all,
                               sample_metadata,
                               output_dir) {
    
    generate_heatmap(dds_all,
                     sample_metadata,
                     paste0(output_dir, "/all_sample_heatmap.png"),
                     n_genes_to_plot = 25000)
    
}
