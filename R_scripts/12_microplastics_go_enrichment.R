# 12_microplastics_go_enrichment.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

microplastics_go_enrichment <- function(dds_all,
                                        res_low_all,
                                        res_high_all,
                                        dds_w6,
                                        res_low_w6,
                                        res_high_w6,
                                        dds_w8,
                                        res_low_w8,
                                        res_high_w8,
                                        dds_gs45,
                                        res_low_gs45,
                                        res_high_gs45,
                                        go_map,
                                        go_term_dict,
                                        output_dir) {
    print("GO GSEA all 1×")
    gsea_res_low_all <- run_gsea(dds_all,
                                  res_low_all,
                                  "Dose_low_vs_control",
                                  go_map,
                                  go_term_dict,
                                  "GO",
                                  output_dir,
                                  "all_timepoints_1×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_low_all)))
    
    print("GO GSEA all 10×")
    gsea_res_high_all <- run_gsea(dds_all,
                                 res_high_all,
                                 "Dose_high_vs_control",
                                 go_map,
                                 go_term_dict,
                                 "GO",
                                 output_dir,
                                 "all_timepoints_10×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_high_all)))
    
    
    print("GO GSEA GS~34 1×")
    gsea_res_low_w6 <- run_gsea(dds_w6,
                                 res_low_w6,
                                 "Dose_low_vs_control",
                                 go_map,
                                 go_term_dict,
                                 "GO",
                                 output_dir,
                                 "GS~34_1×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_low_w6)))
    
    print("GO GSEA GS~34 10×")
    gsea_res_high_w6 <- run_gsea(dds_w6,
                                  res_high_w6,
                                  "Dose_high_vs_control",
                                  go_map,
                                  go_term_dict,
                                  "GO",
                                  output_dir,
                                  "GS~34_10×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_high_w6)))
    
    
    print("GO GSEA GS~42 1×")
    gsea_res_low_w8 <- run_gsea(dds_w8,
                                 res_low_w8,
                                 "Dose_low_vs_control",
                                 go_map,
                                 go_term_dict,
                                 "GO",
                                 output_dir,
                                 "GS~42_1×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_low_w8)))
    
    print("GO GSEA GS~42 10×")
    gsea_res_high_w8 <- run_gsea(dds_w8,
                                  res_high_w8,
                                  "Dose_high_vs_control",
                                  go_map,
                                  go_term_dict,
                                  "GO",
                                  output_dir,
                                  "GS~42_10×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_high_w8)))
    
    
    print("GO GSEA GS45 1×")
    gsea_res_low_gs45 <- run_gsea(dds_gs45,
                                 res_low_gs45,
                                 "Dose_low_vs_control",
                                 go_map,
                                 go_term_dict,
                                 "GO",
                                 output_dir,
                                 "GS45_1×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_low_gs45)))
    
    print("GO GSEA GS45 10×")
    gsea_res_high_gs45 <- run_gsea(dds_gs45,
                                  res_high_gs45,
                                  "Dose_high_vs_control",
                                  go_map,
                                  go_term_dict,
                                  "GO",
                                  output_dir,
                                  "GS45_10×")
    print(paste0("Number of enriched GO terms: ", nrow(gsea_res_high_gs45)))
    
    
    return(list("gsea_res_low_all" = gsea_res_low_all,
                "gsea_res_high_all" = gsea_res_high_all,
                "gsea_res_low_w6" = gsea_res_low_w6,
                "gsea_res_high_w6" = gsea_res_high_w6,
                "gsea_res_low_w8" = gsea_res_low_w8,
                "gsea_res_high_w8" = gsea_res_high_w8,
                "gsea_res_low_gs45" = gsea_res_low_gs45,
                "gsea_res_high_gs45" = gsea_res_high_gs45))
}