data <- read.csv("sample_data.csv")
print("Структура данных:")
str(data)

mean_score <- mean(data$Score)
print(paste("Среднее значение Score:", mean_score))

treatment_data <- subset(data, Group == "Treatment")
max_treatment <- max(treatment_data$Score)
print(paste("Максимальное Score в группе Treatment:", max_treatment))

png("score_boxplot.png", width=800, height=600)
boxplot(Score ~ Group, data = data, main = "Score Distribution by Group", xlab = "Group", ylab = "Score", col = c("lightblue", "lightgreen"))
dev.off()

print("График score_boxplot.png успешно создан")

