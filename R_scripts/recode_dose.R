# recode_dose.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

recode_dose <- function(data) {
    return(fct_recode(data,
                      "0×" = "control",
                      "1×" = "low",
                      "10×" = "high"))
}