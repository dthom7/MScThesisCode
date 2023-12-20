# 10_control_skin_kegg_enrichment.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_kegg_enrichment <- function(dds_control_t2_vs_t1,
                                         res_control_t2_vs_t1,
                                         dds_control_t3_vs_t2,
                                         res_control_t3_vs_t2,
                                         dds_control_t3_vs_t1,
                                         res_control_t3_vs_t1,
                                         kegg_map,
                                         kegg_pathway_dict,
                                         output_dir) {
    print("KEGG GSEA control skin t2 vs t1")
    gsea_res_t2_vs_t1 <- run_gsea(dds_control_t2_vs_t1,
                                  res_control_t2_vs_t1,
                                  "Timepoint_W8_vs_W6",
                                  kegg_map,
                                  kegg_pathway_dict,
                                  "KEGG",
                                  output_dir,
                                  "control_skin_t2_vs_t1")
    print(paste0("Number of enriched KEGG terms: ", nrow(gsea_res_t2_vs_t1)))
    
    print("KEGG GSEA control skin t3 vs t2")
    gsea_res_t3_vs_t2 <- run_gsea(dds_control_t3_vs_t2,
                                  res_control_t3_vs_t2,
                                  "Timepoint_GS45_vs_W8",
                                  kegg_map,
                                  kegg_pathway_dict,
                                  "KEGG",
                                  output_dir,
                                  "control_skin_t3_vs_t2")
    print(paste0("Number of enriched KEGG terms: ", nrow(gsea_res_t3_vs_t2)))
    
    print("KEGG GSEA control skin t3 vs t1")
    gsea_res_t3_vs_t1 <- run_gsea(dds_control_t3_vs_t1,
                                  res_control_t3_vs_t1,
                                  "Timepoint_GS45_vs_W6",
                                  kegg_map,
                                  kegg_pathway_dict,
                                  "KEGG",
                                  output_dir,
                                  "control_skin_t3_vs_t1")
    print(paste0("Number of enriched KEGG terms: ", nrow(gsea_res_t3_vs_t1)))
    
    return(list("gsea_res_t2_vs_t1" = gsea_res_t2_vs_t1,
                "gsea_res_t3_vs_t2" = gsea_res_t3_vs_t2,
                "gsea_res_t3_vs_t1" = gsea_res_t3_vs_t1))
}