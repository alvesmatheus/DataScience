library(tidyverse)
library(stringr)

enade_ufcg <- read_csv(here::here("data/enade-ufcg-2017.csv"))

enade_ufcg$NOME_CURSO <- enade_ufcg$NOME_CURSO %>%
    str_replace("Engenharia \\(1106561\\)", "Engenharia de Biotecnologia e Bioprocessos \\(1106561\\)") %>%
    str_replace("Engenharia \\(118562\\)", "Engenharia de Petróleo \\(118562\\)") %>%
    str_replace("Engenharia \\(13445\\)", "Engenharia de Materiais \\(13445\\)") %>%
    str_replace("Engenharia \\(13444\\)", "Engenharia de Minas \\(13444\\)")

enade_ufcg <- enade_ufcg %>% separate(NOME_CURSO, c("Curso", "Tipo", "e-MEC"), "\\ \\(")
enade_ufcg <- enade_ufcg %>%
    mutate(`e-MEC` = if_else(is.na(`e-MEC`), Tipo, `e-MEC`)) %>%
    mutate(`Tipo` = if_else(`e-MEC` == Tipo, "Bacharelado", Tipo))

enade_ufcg$Tipo <- enade_ufcg$Tipo %>% str_replace("\\)", "")
enade_ufcg$`e-MEC` <- enade_ufcg$`e-MEC` %>% str_replace("\\)", "")

enade_ufcg %>% write_csv(here::here("data/enade-ufcg-2017.csv"))