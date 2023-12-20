# 14_control_skin_venn.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_venn <- function(res_control_t2_vs_t1_filtered,
                              res_control_t3_vs_t2_filtered,
                              res_control_t3_vs_t1_filtered,
                              output_dir) {
    
    venn.diagram(list("GS ~42 vs. GS ~34" = rownames(res_control_t2_vs_t1_filtered),
                      "GS 45 vs. GS ~42" = rownames(res_control_t3_vs_t2_filtered),
                      "GS 45 vs. GS ~34" = rownames(res_control_t3_vs_t1_filtered)),
                 filename = paste0(output_dir, "/control_skin_venn.png"),
                 imagetype = "png",
                 cat.just = list(c(0.2, -0.5), c(0.8, -0.5), c(0.45, 0)),
                 cat.fontface = "bold")
    
}