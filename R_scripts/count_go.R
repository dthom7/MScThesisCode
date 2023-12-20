# count_go.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

count_go <- function(go_result) {
    go_result <- as.data.frame(go_result)
    ont <- select(GO.db, keys = go_result$ID, columns = "ONTOLOGY", keytype = "GOID")
    colnames(ont)[1] <- "ID"
    go_result <- merge(go_result, ont, by = "ID")
    act <- go_result[go_result$NES > 0, ]
    sup <- go_result[go_result$NES < 0, ]
    print("Activated")
    print(paste0("BP: ", nrow(act[act$ONTOLOGY == "BP", ])))
    print(paste0("CC: ", nrow(act[act$ONTOLOGY == "CC", ])))
    print(paste0("MF: ", nrow(act[act$ONTOLOGY == "MF", ])))
    print("Suppressed")
    print(paste0("BP: ", nrow(sup[sup$ONTOLOGY == "BP", ])))
    print(paste0("CC: ", nrow(sup[sup$ONTOLOGY == "CC", ])))
    print(paste0("MF: ", nrow(sup[sup$ONTOLOGY == "MF", ])))
    print(paste0("TOTAL: ", nrow(go_result)))
}
