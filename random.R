library(tidyverse)
library(googlesheets4)
library(googledrive)
library(pdftools)
library(readxl)

## import csv from google form (manual)
note_01 <- read_csv("note_01_20230704.csv")
note_02 <- read_csv("note_02_20230711.csv")
note_03 <- read_csv("note_03_20230718.csv")
note_04 <- read_csv("note_04_20230725.csv")
note_05 <- read_csv("note_05_20230808.csv")
note_06 <- read_csv("note_06_20230821.csv")
plant_life_follow_up <- read_excel("plant_life_follow_up_20230828.xlsx")
note_07 <- read_csv("note_07_20230828.csv")
note_08 <- read_csv("note_08_20230904.csv")
note_09 <- read_csv("note_09_20230911.csv")
note_10 <- read_csv("note_10_20230918.csv")
note_11 <- read_csv("note_11_20230925.csv")
note_12 <- read_csv("note_12_20231002.csv")
note_13 <- read_csv("note_13_20231009.csv")
note_14 <- read_csv("note_14_20231016.csv")

## import csv from google form (api)
#gs4_deauth()
#sheet <- gs4_get("https://docs.google.com/spreadsheets/d/...")
#note_01 <- read_sheet(sheet)

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
#random_note_06 <- slice_sample(note_06, n = 5)
random_note_06
#random_follow_up <- slice_sample(plant_life_follow_up, n = 10)
random_follow_up
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
#random_note_13 <- slice_sample(note_13, n = 5)
random_note_13
#random_note_14 <- slice_sample(note_14, n = 5)
random_note_14

## save random results
write_csv(random_note_01, "note_01_random.csv")
write_csv(random_note_02, "note_02_random.csv")
write_csv(random_note_03, "note_03_random.csv")
write_csv(random_note_04, "note_04_random.csv")
write_csv(random_note_05, "note_05_random.csv")
write_csv(random_note_06, "note_06_random.csv")
write_excel_csv(random_follow_up, "plant_life_follow_up_random.csv")
write_csv(random_note_07, "note_07_random.csv")
write_csv(random_note_08, "note_08_random.csv")
write_csv(random_note_09, "note_09_random.csv")
write_csv(random_note_10, "note_10_random.csv")
write_csv(random_note_11, "note_11_random.csv")
write_csv(random_note_12, "note_12_random.csv")
write_csv(random_note_13, "note_13_random.csv")
write_csv(random_note_14, "note_14_random.csv")

## set google drive authen
drive_auth_configure(path = "xxx.json") #OAuth 2.0 Client IDs

drive_auth_configure(api_key = "xxx")

googledrive::drive_auth()

## download file
file_id <- random_note_14[,5]
colnames(file_id) <- c("url")
file_id$url <- gsub("https://drive.google.com/open\\?id=", "", file_id$url)

for (i in 1:length(file_id$url)) {
  drive_download(file = as_id(file_id$url[i]), path = paste0("random_note_14-",i,".pdf"), overwrite = TRUE)
}

## covert pdf to jpg
pdf_file <- paste0("random_note_14-", seq(1,5,1),".pdf")
jpg_file <- paste0("random_note_14-", seq(1,5,1),".jpg")

for (i in 1:length(pdf_file)) {
  pdf_convert(pdf_file[i], format = "jpeg", filenames = jpg_file[i], dpi = 250)
}
