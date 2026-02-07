##################
# Check sampledf for false paths
##################

args <- commandArgs(trailingOnly = TRUE)
sheet <- args[1]

df <- read.csv(sheet)

if(all(file.exists(as.character(df$fastq_1)))){
  print("All fastq_1 files exist")
}else{
  logic_false <- file.exists(as.character(df$fastq_1))!=TRUE
  print(
    paste(
    "FILE NOT FOUND! from this directory anyways:",
    as.character(df$fastq_1[logic_false])
    )
  )
}

if(all(file.exists(as.character(df$fastq_2)))){
  print("All fastq_2 files exist")
}else{
  logic_false <- file.exists(as.character(df$fastq_2))!=TRUE
  print(
    paste(
      "FILE NOT FOUND! from this directory anyways:",
      as.character(df$fastq_2[logic_false])
    )
  )
}
