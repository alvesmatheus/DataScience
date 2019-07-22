movies_data <- read_csv(here::here("data/rt_hathaway_data.csv"), col_types = "iccdi") %>% 
    rename(title = TITLE, rating = RATING, box_office = BOXOFFICE, year = YEAR, role = CREDIT)

dubbed_movies <- c("Rio", "Rio 2", "Hoodwinked")

movies_data <- movies_data %>%
    filter(!(title %in% dublagens))

write.csv(movies_data, here::here("data/anne_hathaway.csv"), row.names = FALSE)
