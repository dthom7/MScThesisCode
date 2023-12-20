# 24_control_skin_deg_gsea_numbers.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_deg_gsea_numbers <- function(res_control_t2_vs_t1_filtered,
                                          res_control_t3_vs_t2_filtered,
                                          res_control_t3_vs_t1_filtered,
                                          go_gsea_res_control_t2_vs_t1,
                                          go_gsea_res_control_t3_vs_t2,
                                          go_gsea_res_control_t3_vs_t1,
                                          kegg_gsea_res_control_t2_vs_t1,
                                          kegg_gsea_res_control_t3_vs_t2,
                                          kegg_gsea_res_control_t3_vs_t1) {
    
    print("res_control_t2_vs_t1_filtered")
    print(summary(res_control_t2_vs_t1_filtered))
    
    print("res_control_t3_vs_t2_filtered")
    print(summary(res_control_t3_vs_t2_filtered))
    
    print("res_control_t3_vs_t1_filtered")
    print(summary(res_control_t3_vs_t1_filtered))
    
    print("go_gsea_res_control_t2_vs_t1")
    print(count_go(go_gsea_res_control_t2_vs_t1))
    
    print("go_gsea_res_control_t3_vs_t2")
    print(count_go(go_gsea_res_control_t3_vs_t2))
    
    print("go_gsea_res_control_t3_vs_t1")
    print(count_go(go_gsea_res_control_t3_vs_t1))
    
    print("kegg_gsea_res_control_t2_vs_t1")
    print(count_kegg(kegg_gsea_res_control_t2_vs_t1))
    
    print("kegg_gsea_res_control_t3_vs_t2")
    print(count_kegg(kegg_gsea_res_control_t3_vs_t2))
    
    print("kegg_gsea_res_control_t3_vs_t1")
    print(count_kegg(kegg_gsea_res_control_t3_vs_t1))
    
}