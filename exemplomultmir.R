library(multiMiR)

(
  tmp1 <- get_multimir(org = "rno",
                     mirna = deg_mirnas[[1]],
                     table = "validated")
  )

db <- GTF_filtrado %>% 
  separate_wider_delim(cols = X9,delim = ";",names_sep = "_",too_few = "align_start") %>%
  mutate(across(starts_with("X9"), \(x) x %>% str_extract(pattern = "(?<=\\=)[^;]+"))) %>% 
  rename("chr" = 1, "source" =2, "feature" =3,"start"=4,"end"=5,
         "score"=6,"strand"=7,"frame"=8,"ID"=9,"Alias"=10,"Name"=11,"DeriveFrom"=12)


mir1 <- db %>% 
  filter(str_detect(Name, paste0(deg_mirnas[[1]],collapse = "|"))) %>% 
  pull(Name) %>% 
  unique()
(
  tmp1 <- get_multimir(org = "rno",
                       mirna = mir1,table = "validated")
)
