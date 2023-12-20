# 21_control_skin_volcano.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_volcano <- function(res_control_t2_vs_t1,
                                 res_control_t3_vs_t2,
                                 res_control_t3_vs_t1,
                                 output_dir) {
    
    volcano_control_t2_vs_t1 <- EnhancedVolcano(res_control_t2_vs_t1,
                                                rownames(res_control_t2_vs_t1),
                                                x = "log2FoldChange", y = "padj",
                                                pCutoff = alpha,
                                                FCcutoff = log2fc_threshold,
                                                xlab = bquote(~Log[2]~'(fold change)'),
                                                ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                                col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_control_t2_vs_t1.png"),
           plot = volcano_control_t2_vs_t1)
    
    volcano_control_t3_vs_t2 <- EnhancedVolcano(res_control_t3_vs_t2,
                                                rownames(res_control_t3_vs_t2),
                                                x = "log2FoldChange", y = "padj",
                                                pCutoff = alpha,
                                                FCcutoff = log2fc_threshold,
                                                xlab = bquote(~Log[2]~'(fold change)'),
                                                ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                                col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_control_t3_vs_t2.png"),
           plot = volcano_control_t3_vs_t2)
    
    volcano_control_t3_vs_t1 <- EnhancedVolcano(res_control_t3_vs_t1,
                                                rownames(res_control_t3_vs_t1),
                                                x = "log2FoldChange", y = "padj",
                                                pCutoff = alpha,
                                                FCcutoff = log2fc_threshold,
                                                xlab = bquote(~Log[2]~'(fold change)'),
                                                ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                                col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_control_t3_vs_t1.png"),
           plot = volcano_control_t3_vs_t1)
    
}