library(tidyverse)
rno_minra <- readr::read_delim(file = "rno (1).gff3",
                               delim = "\t",col_names = F,
                               comment = "#")


deg_mirnas <- list.files(path = "output/OutPut/Count_Alvos/",full.names = T) %>% 
  map(\(x) x %>% read_csv2) %>% 
  map(\(x) x %>% dplyr::select(miRNA)) %>% 
  map(\(x) pull(x))

(nm <- paste0("B",c(1,2,3,5,6)))
(nm_files <- paste0(nm,".txt"))

walk2(.x = deg_mirnas,.y= nm_files,.f = ~write_lines(x = .x,file = .y))

unique(flatten_chr(deg_mirnas))

TERM <- paste0(unique(flatten_chr(deg_mirnas)),collapse = "|")

GTF_filtrado <- rno_minra %>% 
  filter(str_detect(X9,pattern = TERM))


fn1 <- function(x) {
  y <- str_split(x,"=")
  
  glue::glue('{y[[1]][1]} "{y[[1]][2]}"')
}

write_tsv(GTF_filtrado,"rno_DEmiRs.gff",col_names = F)
GTF_filtrado %>% 
  separate_wider_delim(cols = X9,delim = ";",names_sep = "_",too_few = "align_start") %>%
  mutate(across(starts_with("X9"), \(x) x %>% str_extract(pattern = "(?<=\\=)[^;]+"))) %>% 
  rename("chr" = 1, "source" =2, "feature" =3,"start"=4,"end"=5,
         "score"=6,"strand"=7,"frame"=8,"ID"=9,"Alias"=10,"Name"=11,"DeriveFrom"=12) %>% 
  write_csv(file = "annotations_DEmiRs.csv")
  # View()


# # Ler o arquivo GFF
# dados <- readLines("rno_DEmiRs.gff")
# 
# # Inicializar uma lista para armazenar os dados
# lista_dados <- list()
# 
# # Identificar o número máximo de atributos
# max_atributos <- 0
# 
# # Loop sobre cada linha do arquivo GFF
# for (linha in dados) {
#   # Dividir a linha em campos usando o separador de tabulação
#   campos <- unlist(strsplit(linha, "\t"))
#   
#   # Extrair a coluna de atributos
#   atributos <- campos[9]
#   
#   # Dividir os atributos em pares chave-valor
#   pares <- strsplit(atributos, ";")[[1]]
#   
#   # Inicializar um vetor para armazenar os pares chave-valor
#   atributos_dict <- list()
#   
#   # Loop sobre cada par chave-valor e extrair informações
#   for (par in pares) {
#     # Dividir o par em chave e valor
#     chave_valor <- strsplit(par, "=")[[1]]
#     
#     # Se houver chave e valor, armazená-los no dicionário
#     if (length(chave_valor) == 2) {
#       chave <- chave_valor[1]
#       valor <- chave_valor[2]
#       atributos_dict[[chave]] <- valor
#     }
#   }
#   
#   # Atualizar o número máximo de atributos, se necessário
#   num_atributos <- length(atributos_dict)
#   if (num_atributos > max_atributos) {
#     max_atributos <- num_atributos
#   }
#   
#   # Adicionar o dicionário de atributos à lista de dados
#   lista_dados <- c(lista_dados, list(atributos_dict))
# }
# 
# # Preencher observações com menos atributos
# for (i in seq_along(lista_dados)) {
#   num_atributos <- length(lista_dados[[i]])
#   if (num_atributos < max_atributos) {
#     diff <- max_atributos - num_atributos
#     for (j in 1:diff) {
#       lista_dados[[i]][[paste0("Missing_", j)]] <- NA
#     }
#   }
# }
# 
# # map(lista_dados, \(x) names(x) = c("ID","Alias","Name","DeriveFrom"))
# # Converter a lista de listas em um data frame
# df <- do.call(rbind, lapply(map(lista_dados, \(x) names(x) = c("ID","Alias","Name","DeriveFrom")),
#                             function(x) as.data.frame(t(x))))
# 
# # Exibir o data frame
# print(df)
