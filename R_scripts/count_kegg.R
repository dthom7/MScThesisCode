# count_kegg.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

count_kegg <- function(kegg_result) {
    kegg_result <- as.data.frame(kegg_result)
    act <- kegg_result[kegg_result$NES > 0, ]
    sup <- kegg_result[kegg_result$NES < 0, ]
    print(paste0("Activated: ", nrow(act)))
    print(paste0("Suppressed: ", nrow(sup)))
    print(paste0("Total: ", nrow(kegg_result)))
}
