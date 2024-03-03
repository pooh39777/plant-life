library(tidyverse)
library(googledrive)
library(pdftools)

## import csv from google form (manual)
note_01 <- read_csv("note_01_20231211.csv")
note_02 <- read_csv("note_02_20231218.csv")
note_03 <- read_csv("note_03_20231225.csv")
note_04 <- read_csv("note_04_20240101.csv")
note_05 <- read_csv("note_05_20240108.csv")
note_follow <- read_csv("note_follow_20240111.csv")
note_06 <- read_csv("note_06_20240121.csv")
note_07 <- read_csv("note_07_20240129.csv")
note_08 <- read_csv("note_08_20240205.csv")
note_09 <- read_csv("note_09_20240212.csv")
note_10 <- read_csv("note_10_20240218.csv")
ืnote_11 <- read_csv("note_11_20240226.csv")
note_12 <- read_csv("note_12_20240302.csv")

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
#random_note_follow <- slice_sample(note_follow, n = 10)
random_note_follow
#random_note_06 <- slice_sample(note_06, n = 5)
random_note_06
#random_note_07 <- slice_sample(note_07, n = 5)
random_note_07
#random_note_08 <- slice_sample(note_08, n = 5)
random_note_08
#random_note_09 <- slice_sample(note_09, n = 5)
random_note_09
#random_note_10 <- slice_sample(note_10, n = 5)
random_note_10
#random_note_11 <- slice_sample(note_11, n = 5)
random_note_11
#random_note_12 <- slice_sample(note_12, n = 5)
random_note_12

## save random results
write_csv(random_note_01, "note_01_random.csv")
write_csv(random_note_02, "note_02_random.csv")
write_csv(random_note_03, "note_03_random.csv")
write_csv(random_note_04, "note_04_random.csv")
write_csv(random_note_05, "note_05_random.csv")
write_csv(random_note_follow, "note_follow_random.csv")
write_csv(random_note_06, "note_06_random.csv")
write_csv(random_note_07, "note_07_random.csv")
write_csv(random_note_08, "note_08_random.csv")
write_csv(random_note_09, "note_09_random.csv")
write_csv(random_note_10, "note_10_random.csv")
write_csv(random_note_11, "note_11_random.csv")
write_csv(random_note_12, "note_12_random.csv")

## set google drive authen
#drive_auth_configure(path = "xxx.json") #OAuth 2.0 Client IDs
#drive_auth_configure(api_key = "xxx")
googledrive::drive_auth()

## set url to download files
file_id <- random_note_12[,5]
colnames(file_id) <- c("url")
file_id$url <- gsub("https://drive.google.com/open\\?id=", "", file_id$url)

## create folder to download pdf files
dir.create("./note_12_random")
dir.create("./note_12_random/pdf")

## download files
for (i in 1:length(file_id$url)) {
  drive_download(file = as_id(file_id$url[i]), path = paste0("./note_12_random/pdf/","note_12_random-",i,".pdf"), overwrite = TRUE)
}

## create folder to convert files
dir.create("./note_12_random/jpg")

pdf_file <- paste0("./note_12_random/pdf/note_12_random-", seq(1,length(file_id$url),1),".pdf")
jpg_file <- paste0("./note_12_random/jpg/note_12_random-", seq(1,length(file_id$url),1),".jpg")

## convert pdf to jpg
for (i in 1:length(pdf_file)) {
  pdf_convert(pdf_file[i], format = "jpeg", filenames = jpg_file[i], dpi = 250)
}
