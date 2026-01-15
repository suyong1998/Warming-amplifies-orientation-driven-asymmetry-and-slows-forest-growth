
# ------------------------------------------------------------
library(dplR)
library(tidyverse)

# ------------------------------------------------------------
# 1️⃣ 
# ------------------------------------------------------------
site_csv  <- "..//Rawdata/sitede.csv"
rwl_dir   <- "..//Rawdata/RWI"
output_dir <- "..//Rawdata/BAI"
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)


sites <- read.csv(site_csv, stringsAsFactors = FALSE)$site
sites <- unique(trimws(sites))
message("📋  ", length(sites), " 。")


for (site in sites) {
  message("🟢 ：", site)
  

  rwl_files <- list.files(
    rwl_dir,
    pattern = paste0("^", site, "[0-9]*\\.rwl$"),
    full.names = TRUE,
    ignore.case = TRUE
  )
  
  if (length(rwl_files) == 0) {
    message("⚠️ ", site)
    next
  }
  

  for (rwl_file in rwl_files) {
    message("  ", basename(rwl_file))
    

    rwl <- tryCatch({
      read.rwl(rwl_file)
    }, error = function(e) {
      message("  ❌ 文", e$message)
      return(NULL)
    })
    if (is.null(rwl)) next
    

    bai <- bai.out(rwl = rwl)
    

    bai.crn <- chron(bai)
    yrs <- time(bai.crn)
    

    bai_df <- data.frame(Year = as.numeric(rownames(bai)), bai)
    bai_mean_df <- data.frame(Year = yrs, Mean_BAI = bai.crn[, 1])
    
    write.csv(bai_df,
              file = file.path(output_dir, paste0("BAI_", site, "_allcores.csv")),
              row.names = FALSE)
    write.csv(bai_mean_df,
              file = file.path(output_dir, paste0("BAI_", site, "_mean.csv")),
              row.names = FALSE)
    
    message("  ✅ ：", site)
    

    png(file.path(output_dir, paste0("BAI_", site, ".png")),
        width = 1000, height = 600, res = 150)
    plot(yrs, bai.crn[, 1], type = "n",
         main = paste("Basal Area Increment (BAI) -", site),
         xlab = "Year", ylab = expression(mm^2))
    lines(yrs, bai.crn[, 1], col = "grey40", lty = "dashed")
    lines(yrs, caps(bai.crn[, 1], nyrs = 32), col = "red", lwd = 2)
    dev.off()
  }
}

message("🎯 ！")


