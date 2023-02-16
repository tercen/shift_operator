suppressPackageStartupMessages({
  library(tercenApi)
  library(tercen)
  library(data.table)
  library(dtplyr)
  library(dplyr)
})

ctx <- tercenCtx()
constant <- ctx$op.value('constant', as.double, 0)

df_out <- ctx %>% 
  select(.x, .y, .ci, .ri) %>% 
  lazy_dt() %>%
  group_by(.ci, .ri)

cts <- df_out %>% summarise(N = n())

if(any(as_tibble(cts)[["N"]] > 1)) {
  stop("This operator requires a single data point per cell.")
}

df_out %>%
  transmute(value = .y + constant) %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()