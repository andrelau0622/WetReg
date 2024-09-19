# 加载数据
load_data <- function(dat_path) {
  list.files(dat_path)
  load(paste(dat_path, "/", "dt_fin.rdata", sep = ""))
}
