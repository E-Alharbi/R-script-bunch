#!/usr/bin/env Rscript



library_list <- list("ggplot2")
load_library_list.function <- function(library_list) {
    for(i in library_list)
    {
        found=lapply(i, require, character.only = TRUE,quietly = T)
        
    if (!found[[1]]) {
        stop(paste0(i," library not found! Please install this library and re-run the script again."))
        
        
    }

    }
}




