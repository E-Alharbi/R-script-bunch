#!/usr/bin/env Rscript


load_library_list.function <- function(library_list) {
    for(i in library_list)
    {
        found=lapply(i, require, character.only = TRUE,quietly = T)
        
    if (!found[[1]]) {
        stop(paste0(i," library not found! Please install this library and re-run the script again."))
        
        
    }

    }
}

set_up_env_options.function <- function() {
    options(warn=-1)
}

check_keyword_value.function <- function(keyword){
    
    if (keyword@type =="file" && keyword@in_out =="in"){
        if(!file.exists(keyword@value)){
            stop(paste0(keyword@value," file not found!"))
        }
    }
    
}

check_col.function <- function(col,data){
    
    if(col %in% colnames(data))
    {
      return (col)
    }
    else{
        stop(paste0(col," column not found in the CSV file!"))
    }
    
}




set_up_keyword_values.function <- function(keywords, args) {
    args <- commandArgs(trailingOnly = TRUE)
    args<-strsplit(args, "\\s+")
    i<-1
    
    for (k in args){
        if(startsWith(k, "-")){
            k <- gsub('-', '', k)
            if(!is.null(keywords[[k]])){
                if(i+1 <= length(args) && !startsWith(args[[i+1]], "-")){
                keywords[[k]]@value <- args[[i+1]]
                check_keyword_value.function(keywords[[k]])
                }
                else{
                    stop(paste0(" please set a value for this keyword ",k))
                }
            }
            else{
                stop(paste0(k," unknown keyword!"))
            }
        }
        i<-i +1
        
    }
    
    
}



set_shape.function <- function(col){
    shapes <- c()
    i <- 0
    for (g in col){
        
        shapes[[i+1]] <- i # i+1 becuase first element index is 1
        i <- i + 1
    }
    return (shapes)
}
get_color.function <- function(r_color,index){
    
    
}

set_color.function <- function(col){
    colors <- c()
    
    r_color <- c("red", "blue", "green" , "#000000", "#E69F00", "#56B4E9", "#009E73","#F0E442", "#0072B2", "#D55E00", "#CC79A7","#29BF12","#FFBF00")
    if(length(col) > length(r_color)){
        print("The number of groups is higher than the number of colors. We will duplicate the use of a color. ")
    }
    i <- 1
    i_color<-1
    for (g in col){
        colors[[i]] <- r_color[[i_color]]
        i <- i+1
        i_color <- i_color+1
        if(i_color > length(r_color)){
            i_color<-1
        }
    }
    return (colors)
}



