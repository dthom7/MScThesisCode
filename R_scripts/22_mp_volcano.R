# 22_mp_volcano.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

mp_volcano <- function(res_low_w6,
                       res_high_w6,
                       res_low_w8,
                       res_high_w8,
                       res_low_gs45,
                       res_high_gs45,
                       output_dir) {
    
    volcano_low_w6 <- EnhancedVolcano(res_low_w6,
                                      rownames(res_low_w6),
                                      x = "log2FoldChange", y = "padj",
                                      pCutoff = alpha,
                                      FCcutoff = log2fc_threshold,
                                      xlab = bquote(~Log[2]~'(fold change)'),
                                      ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                      col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_low_w6.png"),
           plot = volcano_low_w6)
    
    volcano_high_w6 <- EnhancedVolcano(res_high_w6,
                                       rownames(res_high_w6),
                                       x = "log2FoldChange", y = "padj",
                                       pCutoff = alpha,
                                       FCcutoff = log2fc_threshold,
                                       xlab = bquote(~Log[2]~'(fold change)'),
                                       ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                       col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_high_w6.png"),
           plot = volcano_high_w6)
    
    volcano_low_w8 <- EnhancedVolcano(res_low_w8,
                                      rownames(res_low_w8),
                                      x = "log2FoldChange", y = "padj",
                                      pCutoff = alpha,
                                      FCcutoff = log2fc_threshold,
                                      xlab = bquote(~Log[2]~'(fold change)'),
                                      ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                      col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_low_w8.png"),
           plot = volcano_low_w8)
    
    volcano_high_w8 <- EnhancedVolcano(res_high_w8,
                                       rownames(res_high_w8),
                                       x = "log2FoldChange", y = "padj",
                                       pCutoff = alpha,
                                       FCcutoff = log2fc_threshold,
                                       xlab = bquote(~Log[2]~'(fold change)'),
                                       ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                       col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_high_w8.png"),
           plot = volcano_high_w8)
    
    volcano_low_gs45 <- EnhancedVolcano(res_low_gs45,
                                        rownames(res_low_gs45),
                                        x = "log2FoldChange", y = "padj",
                                        pCutoff = alpha,
                                        FCcutoff = log2fc_threshold,
                                        xlab = bquote(~Log[2]~'(fold change)'),
                                        ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                        col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_low_gs45.png"),
           plot = volcano_low_gs45)
    
    volcano_high_gs45 <- EnhancedVolcano(res_high_gs45,
                                         rownames(res_high_gs45),
                                         x = "log2FoldChange", y = "padj",
                                         pCutoff = alpha,
                                         FCcutoff = log2fc_threshold,
                                         xlab = bquote(~Log[2]~'(fold change)'),
                                         ylab = bquote('-'~Log[10]~'(adjusted p)'),
                                         col=c('black', 'black', 'black', 'red2'))
    ggsave(paste0(output_dir, "/volcano_high_gs45.png"),
           plot = volcano_high_gs45)
    
}