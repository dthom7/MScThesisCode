# 18_mp_deg_heatmaps.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

mp_deg_heatmaps <- function(dds_w6,
                            res_low_w6_filtered,
                            res_high_w6_filtered,
                            dds_w8,
                            res_low_w8_filtered,
                            res_high_w8_filtered,
                            dds_gs45,
                            res_low_gs45_filtered,
                            res_high_gs45_filtered,
                            sample_metadata,
                            output_dir) {
    
    generate_heatmap(dds_w6,
                     sample_metadata[sample_metadata$Timepoint == "W6" &
                                         sample_metadata$Dose != "high", ],
                     paste0(output_dir, "/w6_low_only_deg_heatmap.png"),
                     gene_list = unique(rownames(res_low_w6_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~34" = "#F0E442"),
                                               Dose = c("0×" = "#E69F00",
                                                        "1×" = "#56B4E9")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_w6,
                     sample_metadata[sample_metadata$Timepoint == "W6" &
                                         sample_metadata$Dose != "low", ],
                     paste0(output_dir, "/w6_high_only_deg_heatmap.png"),
                     gene_list = unique(rownames(res_high_w6_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~34" = "#F0E442"),
                                               Dose = c("0×" = "#E69F00",
                                                        "10×" = "#009E73")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_w8,
                     sample_metadata[sample_metadata$Timepoint == "W8" &
                                         sample_metadata$Dose != "high", ],
                     paste0(output_dir, "/w8_low_only_deg_heatmap.png"),
                     gene_list = unique(rownames(res_low_w8_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~42" = "#0072B2"),
                                               Dose = c("0×" = "#E69F00",
                                                        "1×" = "#56B4E9")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_w8,
                     sample_metadata[sample_metadata$Timepoint == "W8" &
                                         sample_metadata$Dose != "low", ],
                     paste0(output_dir, "/w8_high_only_deg_heatmap.png"),
                     gene_list = unique(rownames(res_high_w8_filtered)),
                     annotation_colours = list(Timepoint = c("GS ~42" = "#0072B2"),
                                               Dose = c("0×" = "#E69F00",
                                                        "10×" = "#009E73")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_gs45,
                     sample_metadata[sample_metadata$Timepoint == "GS45" &
                                         sample_metadata$Dose != "high", ],
                     paste0(output_dir, "/gs45_low_only_deg_heatmap.png"),
                     gene_list = unique(rownames(res_low_gs45_filtered)),
                     annotation_colours = list(Timepoint = c("GS 45" = "#D55E00"),
                                               Dose = c("0×" = "#E69F00",
                                                        "1×" = "#56B4E9")),
                     filter_samples = TRUE)
    
    generate_heatmap(dds_gs45,
                     sample_metadata[sample_metadata$Timepoint == "GS45" &
                                         sample_metadata$Dose != "low", ],
                     paste0(output_dir, "/gs45_high_only_deg_heatmap.png"),
                     gene_list = unique(rownames(res_high_gs45_filtered)),
                     annotation_colours = list(Timepoint = c("GS 45" = "#D55E00"),
                                               Dose = c("0×" = "#E69F00",
                                                        "10×" = "#009E73")),
                     filter_samples = TRUE)
    
}
