# 17_control_skin_deg_heatmaps.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_deg_heatmaps <- function(dds_control_t2_vs_t1,
                                      res_control_t2_vs_t1_filtered,
                                      dds_control_t3_vs_t2,
                                      res_control_t3_vs_t2_filtered,
                                      dds_control_t3_vs_t1,
                                      res_control_t3_vs_t1_filtered,
                                      sample_metadata,
                                      output_dir) {
    
    generate_heatmap(dds_control_t2_vs_t1,
                     sample_metadata[sample_metadata$Dose == "control" &
                                         sample_metadata$Timepoint != "GS45", ],
                     paste0(output_dir, "/control_deg_heatmap_t2vst1_only_t2_t1_samples.png"),
                     gene_list = unique(rownames(res_control_t2_vs_t1_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~34" = "#F0E442",
                                                             "GS ~42" = "#0072B2"),
                                               Dose = c("0×" = "#E69F00")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_control_t3_vs_t2,
                     sample_metadata[sample_metadata$Dose == "control" &
                                         sample_metadata$Timepoint != "W6", ],
                     paste0(output_dir, "/control_deg_heatmap_t3vst2_only_t3_t2_samples.png"),
                     gene_list = unique(rownames(res_control_t3_vs_t2_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~42" = "#0072B2",
                                                             "GS 45" = "#D55E00"),
                                               Dose = c("0×" = "#E69F00")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_control_t3_vs_t1,
                     sample_metadata[sample_metadata$Dose == "control" &
                                         sample_metadata$Timepoint != "W8", ],
                     paste0(output_dir, "/control_deg_heatmap_t3vst1_only_t3_t1_samples.png"),
                     gene_list = unique(rownames(res_control_t3_vs_t1_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~34" = "#F0E442",
                                                             "GS 45" = "#D55E00"),
                                               Dose = c("0×" = "#E69F00")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_control_t2_vs_t1,
                     sample_metadata[sample_metadata$Dose == "control", ],
                     paste0(output_dir, "/control_deg_heatmap_core_deg.png"),
                     gene_list = intersect(rownames(res_control_t2_vs_t1_filtered),
                                           intersect(rownames(res_control_t3_vs_t1_filtered),
                                                     rownames(res_control_t3_vs_t2_filtered))),
                     annotation_colours = list(Timepoint = c("GS ~34" = "#F0E442",
                                                             "GS ~42" = "#0072B2",
                                                             "GS 45" = "#D55E00"),
                                               Dose = c("0×" = "#E69F00")),
                     filter_samples = TRUE)
    
}
