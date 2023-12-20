# run_gsea.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

run_gsea <- function(dds,
                     res,
                     coef,
                     term2gene,
                     term2name,
                     type,
                     output_dir,
                     sample_type_output_prefix) {
    shrunk_lfc <- lfcShrink(dds,
                            coef = coef,
                            res = res,
                            type = "apeglm")
    gene_list <- shrunk_lfc$log2FoldChange
    names(gene_list) <- rownames(shrunk_lfc)
    gene_list <- sort(gene_list, decreasing = TRUE)
    
    set.seed(629974668)
    gsea_res <- GSEA(geneList = gene_list,
                     TERM2GENE = term2gene,
                     TERM2NAME = term2name,
                     seed = TRUE,
                     eps = 0)
    
    write.csv(as.data.frame(gsea_res),
              file = paste0(output_dir,
                            "/",
                            sample_type_output_prefix,
                            "gsea_",
                            type,
                            ".csv"),
              row.names = FALSE)
    
    return(gsea_res)
}