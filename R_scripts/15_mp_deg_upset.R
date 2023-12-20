# 15_mp_deg_upset.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

mp_deg_upset <- function(res_low_w6_filtered,
                         res_high_w6_filtered,
                         res_low_w8_filtered,
                         res_high_w8_filtered,
                         res_low_gs45_filtered,
                         res_high_gs45_filtered,
                         output_dir) {
    
    deg_list <- list("GS ~34 1×" = rownames(res_low_w6_filtered),
                     "GS ~34 10×" = rownames(res_high_w6_filtered),
                     "GS ~42 1×" = rownames(res_low_w8_filtered),
                     "GS ~42 10×" = rownames(res_high_w8_filtered),
                     "GS 45 1×" = rownames(res_low_gs45_filtered),
                     "GS 45 10×" = rownames(res_high_gs45_filtered))
    upset_plot <- upset(fromList(deg_list), keep.order = TRUE, nsets = 6)
    png(file = paste0(output_dir, "/mp_deg_upset.png"),
        height = 2000,
        width = 2000,
        res = 400)
    print(upset_plot)
    dev.off()
    
}