# A bunch of R scripts
These R scripts are those that I used to visualise the results in my research papers. For each script, I show an example of data structure, a produced plot and the command line with parameters, if any, to run the script from the command line. The scripts are free and ready to use.      

## Script 1 (line plot)
<p align="center">
<img src="Scripts/Script1/Plot_example.png" alt="drawing" width="400"/>
</p>

- Command line
```
Rscript Script1.r -CSV_file Data_example.csv
```
- Command line keywords


  
| keyword | Description | Default value |
| ------ | ----------- |-----------  |
| -CSV_file   | Path to CSV file. | Data_example.csv |
| -Plot_name | Created plot name | Plot.png |
| -x_label    |  a column name in the CSV file to use a x axis  | Resolution  |
| -y_label    |  a column name in the CSV file to use a y axis | Completness |
| -group_label    |   a column name in the CSV file to group the data  | Pipeline |
| -font_size    |   x and y axis labels fonts size  | 14 |

## Citing
@software{A_bunch_of_R_scripts,
  author = {Alharbi,Emad},
  doi = {},
  month = {03},
  title = {{A bunch of R scripts}},
  url = {https://github.com/E-Alharbi/rscript-bunch},
  year = {2022}
}
