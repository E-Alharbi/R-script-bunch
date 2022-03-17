#!/usr/bin/env Rscript
############################################
#         Download utilities.r             #
############################################

utilities_file="utilities.r"
if(!file.exists(utilities_file)){
    print (paste0(utilities_file," not found. We will download from rscript-bunch repository.
"))
download.file("https://raw.githubusercontent.com/E-Alharbi/R-script-bunch/main/utilities.r", utilities_file,method='curl')

}

############################################
#  Load libraies and set up env options    #
############################################

source(utilities_file)
set_up_env_options.function()

library_list <- list("hash","ggplot2","directlabels","data.table")
load_library_list.function(library_list)

############################################
#             Keywords                     #
############################################
setClass("keyword", slots=list(name="character",type="character", in_out="character", value="character"))
keywords <- hash()
keywords[["CSV_file"]] <- new("keyword",name="CSV_file",type="file", in_out="in", value="./Data_example.csv")
keywords[["Plot_name"]] <- new("keyword",name="Plot_name",type="file", in_out="out", value="Plot.png")
keywords[["x_label"]] <- new("keyword",name="x_label",type="col", in_out="in", value="CompareTo")
keywords[["y_label"]] <- new("keyword",name="y_label",type="col", in_out="in", value="Percentage")
keywords[["group_label"]] <- new("keyword",name="group_label",type="col", in_out="in", value="Pipeline")
keywords[["font_size"]] <- new("keyword",name="font_size",type="size", in_out="in", value="14")
set_up_keyword_values.function(keywords,args)


############################################
#             Prepare data                 #
############################################

MyData <- read.csv(file=keywords[["CSV_file"]]@value, header=TRUE, sep=",")
MyData <- setnames(MyData,c(check_col.function(keywords[["x_label"]]@value,MyData),check_col.function(keywords[["y_label"]]@value,MyData),check_col.function(keywords[["group_label"]]@value,MyData)),c("x_label","y_label","group_label"))
y_min<- min(as.numeric(MyData$y_label))
y_max<- max(as.numeric(MyData$y_label))
row_num <- ceiling(length(unique(MyData$group_label)) / 3)

############################################
#             Create plot                  #
############################################

png(keywords[["Plot_name"]]@value, units="in", width=7, height=7.2, res=1000)
ggplot(data=MyData, aes(x=MyData$x_label, y=MyData$y_label, fill=MyData$x_label)) +geom_bar(stat="identity", position=position_dodge(), colour=NA,show.legend = FALSE) + ylim(y_min, y_max) +  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +annotate("text", x= 8, y = 60, label =MyData$group_label, size =3)+facet_wrap(~MyData$group_label ,nrow = row_num , ncol = 3)  +theme(axis.title.x=element_blank(),                                                              axis.text.x=element_blank(),                                                        axis.ticks.x=element_blank()) +theme(axis.line = element_line(colour = "black"),panel.grid.major = element_blank()) + theme(panel.background = element_blank() , panel.border = element_rect(colour = "black", fill=NA))+theme(strip.background = element_rect(fill=NA)) + scale_fill_discrete(name = keywords[["x_label"]]@value) +ylab(keywords[["y_label"]]@value)+theme(strip.text.x = element_blank())+
theme(legend.position="bottom") + theme(
legend.key.size = unit(0.5, "cm"),
legend.key.width = unit(0.3,"cm")
) +guides(fill=guide_legend(nrow=1,byrow=TRUE,label.position = "bottom",title.position = "top",title.hjust = 0.5,title.vjust = 1.2,label.theme = element_text(angle = 90,size=9),legend.spacing.c = unit(10.0, 'cm'))) +theme(legend.text = element_text(margin = margin(r = 2, unit = 'in'))) +theme(
legend.spacing.x = unit(0.5, 'cm'),
legend.spacing.y = unit(0, 'cm'),legend.box.margin=margin(-10,-10,-10,-10)
)+
geom_dl(aes(label = MyData$x_label), method = list(dl.trans(y = y + 0.01), "last.points", cex = 0.5,rot=c(90)))+theme(axis.text=element_text(size=keywords[["font_size"]]@value),axis.title=element_text(size=keywords[["font_size"]]@value))+theme(legend.spacing.x = unit(0.05, 'cm'))+ theme(legend.text=element_text(size=keywords[["font_size"]]@value))
dev.off()

