library(tidyverse)
library(googledrive)
library(pdftools)

## import csv from google form (manual)
note_01 <- read_csv("note_01_20231211.csv")
note_02 <- read_csv("note_02_20231218.csv")
note_03 <- read_csv("note_03_20231225.csv")
note_04 <- read_csv("note_04_20240101.csv")
note_05 <- read_csv("note_05_20240108.csv")

## random select students
#random_note_01 <- slice_sample(note_01, n = 5)
random_note_01
#random_note_02 <- slice_sample(note_02, n = 5)
random_note_02
#random_note_03 <- slice_sample(note_03, n = 5)
random_note_03
#random_note_04 <- slice_sample(note_04, n = 5)
random_note_04
#random_note_05 <- slice_sample(note_05, n = 5)
random_note_05

## save random results
write_csv(random_note_01, "note_01_random.csv")
write_csv(random_note_02, "note_02_random.csv")
write_csv(random_note_03, "note_03_random.csv")
write_csv(random_note_04, "note_04_random.csv")
write_csv(random_note_05, "note_05_random.csv")

## set google drive authen
#drive_auth_configure(path = "xxx.json") #OAuth 2.0 Client IDs
#drive_auth_configure(api_key = "xxx")
googledrive::drive_auth()

## set url to download files
file_id <- random_note_05[,5]
colnames(file_id) <- c("url")
file_id$url <- gsub("https://drive.google.com/open\\?id=", "", file_id$url)

## create folder to download pdf files
dir.create("./note_05_random")
dir.create("./note_05_random/pdf")

## download files
for (i in 1:length(file_id$url)) {
  drive_download(file = as_id(file_id$url[i]), path = paste0("./note_05_random/pdf/","note_05_random-",i,".pdf"), overwrite = TRUE)
}

## create folder to convert files
dir.create("./note_05_random/jpg")

pdf_file <- paste0("./note_05_random/pdf/note_05_random-", seq(1,5,1),".pdf")
jpg_file <- paste0("./note_05_random/jpg/note_05_random-", seq(1,5,1),".jpg")

## convert pdf to jpg
for (i in 1:length(pdf_file)) {
  pdf_convert(pdf_file[i], format = "jpeg", filenames = jpg_file[i], dpi = 250)
}
