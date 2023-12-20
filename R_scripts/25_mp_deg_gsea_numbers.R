# 25_mp_deg_gsea_numbers.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

mp_deg_gsea_numbers <- function(res_low_w6_filtered,
                                res_high_w6_filtered,
                                res_low_w8_filtered,
                                res_high_w8_filtered,
                                res_low_gs45_filtered,
                                res_high_gs45_filtered,
                                go_gsea_res_low_w6,
                                go_gsea_res_high_w6,
                                go_gsea_res_low_w8,
                                go_gsea_res_high_w8,
                                go_gsea_res_low_gs45,
                                go_gsea_res_high_gs45,
                                kegg_gsea_res_low_w6,
                                kegg_gsea_res_high_w6,
                                kegg_gsea_res_low_w8,
                                kegg_gsea_res_high_w8,
                                kegg_gsea_res_low_gs45,
                                kegg_gsea_res_high_gs45) {
    
    print("res_low_w6_filtered")
    print(summary(res_low_w6_filtered))
    
    print("res_high_w6_filtered")
    print(summary(res_high_w6_filtered))
    
    print("res_low_w8_filtered")
    print(summary(res_low_w8_filtered))
    
    print("res_high_w8_filtered")
    print(summary(res_high_w8_filtered))
    
    print("res_low_gs45_filtered")
    print(summary(res_low_gs45_filtered))
    
    print("res_high_gs45_filtered")
    print(summary(res_high_gs45_filtered))
    
    print("go_gsea_res_low_w6")
    print(count_go(go_gsea_res_low_w6))
    
    print("go_gsea_res_high_w6")
    print(count_go(go_gsea_res_high_w6))
    
    print("go_gsea_res_low_w8")
    print(count_go(go_gsea_res_low_w8))
    
    print("go_gsea_res_high_w8")
    print(count_go(go_gsea_res_high_w8))
    
    print("go_gsea_res_low_gs45")
    print(count_go(go_gsea_res_low_gs45))
    
    print("go_gsea_res_high_gs45")
    print(count_go(go_gsea_res_high_gs45))
    
    print("kegg_gsea_res_low_w6")
    print(count_kegg(kegg_gsea_res_low_w6))
    
    print("kegg_gsea_res_high_w6")
    print(count_kegg(kegg_gsea_res_high_w6))
    
    print("kegg_gsea_res_low_w8")
    print(count_kegg(kegg_gsea_res_low_w8))
    
    print("kegg_gsea_res_high_w8")
    print(count_kegg(kegg_gsea_res_high_w8))
    
    print("kegg_gsea_res_low_gs45")
    print(count_kegg(kegg_gsea_res_low_gs45))
    
    print("kegg_gsea_res_high_gs45")
    print(count_kegg(kegg_gsea_res_high_gs45))
    
}