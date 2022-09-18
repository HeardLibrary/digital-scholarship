old_frame <- read.csv("~/downloads/commons_images.csv")
new_frame <- read.csv("~/downloads/commons_images_add.csv")
old_frame <- rbind(old_frame, new_frame)
write.csv(old_frame, "~/downloads/commons_images.csv", row.names = FALSE)
