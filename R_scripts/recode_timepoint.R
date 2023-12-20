# recode_timepoint.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

recode_timepoint <- function(data) {
    return(fct_recode(data,
                      "GS ~34" = "W6",
                      "GS ~42" = "W8",
                      "GS 45" = "GS45"))
}