library(tidyverse)
library(stringr)

cursos_ufcg <- read_csv(here::here("data/cursos-ufcg.csv"))

cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("Engª", "Engenharia")
cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("Eng.ª", "Engenharia")

cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("\\(Língua Portuguesa e Língua Francesa\\)", "- Língua Portuguesa e Língua Francesa")
cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("\\(Língua Inglesa\\)", "- Língua Inglesa")
cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("\\(Língua Portuguesa\\)", "- Língua Portuguesa")
cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("\\(Língua Espanhola\\)", "- Língua Espanhola")

cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("Música \\(Licenciatura\\)", "Música")
cursos_ufcg$cursos <- cursos_ufcg$cursos %>% str_replace("Música \\(Bacharelado\\)", "Música")

cursos_ufcg <- cursos_ufcg %>%
    filter(!is.na(codigo) && !is.na(cursos)) %>%
    separate(codigo, c("e-MEC", "IES"), "/") %>%
    separate(cursos, c("Curso/Centro", "Turno/Vagas"), "\\ \\(") %>%
    separate("Curso/Centro", c("Curso", "Centro"), "/")

cursos_ufcg <- cursos_ufcg %>% select(Curso, Centro, `e-MEC`)

cursos_ufcg %>% write_csv(here::here("data/cursos-ufcg-por-centro.csv"))