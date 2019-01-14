library(tercen)
library(dplyr)

ctx = tercenCtx()
constant = as.double(ctx$op.value('constant'))

ctx %>% 
  select(.y) %>% 
  transmute(shift = (.y + constant)) %>%
  ctx$addNamespace() %>%
  ctx$save()