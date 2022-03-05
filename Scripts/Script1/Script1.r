#!/usr/bin/env Rscript

############################################
#         Download utilities.r             #
############################################

utilities_file="utilities.r"
if(!file.exists(utilities_file)){
    print (paste0(utilities_file," not found. We will download from rscript-bunch repository.
"))
download.file("https://raw.githubusercontent.com/E-Alharbi/rscript-bunch/main/utilities.r", utilities_file,method='curl')

}

############################################
#  Load libraies and set up env options    #
############################################

source(utilities_file)
set_up_env_options.function()

library_list <- list("hash","ggplot2")
load_library_list.function(library_list)

############################################
#             Keywords                     #
############################################

setClass("keyword", slots=list(name="character",type="character", in_out="character", value="character"))
keywords <- hash()
keywords[["CSV_file"]] <- new("keyword",name="CSV_file",type="file", in_out="in", value="./Data_example.csv")
keywords[["Plot_name"]] <- new("keyword",name="Plot_name",type="file", in_out="out", value="Plot.png")
keywords[["x_label"]] <- new("keyword",name="x_label",type="col", in_out="in", value="Resolution")
keywords[["y_label"]] <- new("keyword",name="y_label",type="col", in_out="in", value="Completness")
keywords[["group_label"]] <- new("keyword",name="y_label",type="col", in_out="in", value="Pipeline")
keywords[["font_size"]] <- new("keyword",name="font_size",type="size", in_out="in", value="14")
set_up_keyword_values.function(keywords,args)


############################################
#             Prepare data                 #
############################################

MyData <- read.csv(file=keywords[["CSV_file"]]@value, header=TRUE, sep=",")
group <-toString(check_col.function(keywords[["group_label"]]@value,MyData))
x <-toString(check_col.function(keywords[["x_label"]]@value,MyData))
y <-toString(check_col.function(keywords[["y_label"]]@value,MyData))
col<- c(group,x)
grouped <- setNames(aggregate(MyData[y], by=MyData[col], mean),c("group_label","x_label","y_label" ))
grouped$x_label <- gsub('\t', '\n', grouped$x_label)
y_min<- min(as.numeric(grouped$y_label))
y_max<- max(as.numeric(grouped$y_label))
shapes <- set_shape.function(unique(grouped$group_label))
colors <- set_color.function(unique(grouped$group_label))

############################################
#             Create plot                  #
############################################

png(keywords[["Plot_name"]]@value, units="in", width=7, height=5, res=1000)

ggplot(grouped, aes(x=x_label, y=as.numeric(y_label),group=as.factor(group_label) , color=as.factor(group_label),shape=as.factor(group_label) )) +  geom_line(aes(color=as.factor(group_label) ) ) + geom_point(aes(color=as.factor(group_label),shape=as.factor(group_label)),size = 1) + scale_shape_manual(values = shapes,guide = guide_legend(ncol = 3)) +theme(legend.direction = "horizontal") + theme(legend.title = element_blank()) + theme( legend.position=c(0.6,0.90) , legend.spacing.x = unit(0.1, 'cm'))  + theme(legend.key.width=unit(0.6,"cm"), legend.key = element_rect(colour = "transparent", fill = "transparent") ,legend.background = element_rect(fill=alpha('white', 0))) + theme(panel.background = element_blank() , panel.border = element_rect(colour = "black" , fill=NA)) +labs(x = keywords[["x_label"]]@value , y = keywords[["y_label"]]@value) + scale_color_manual(values=colors) + ylim(y_min, y_max)  + theme(legend.key.width = unit(0.9,"cm"))+theme(axis.text=element_text(size=keywords[["font_size"]]@value),axis.title=element_text(size=keywords[["font_size"]]@value))+theme(legend.spacing.x = unit(0.05, 'cm'))+ theme(legend.text=element_text(size=keywords[["font_size"]]@value))



invisible(capture.output(dev.off()))

if(file.exists(keywords[["Plot_name"]]@value))
print("Plot was created!")





