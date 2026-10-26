library(tidyverse)
library(here)
library(ggplot2)
library(scales)

# Load the data
setwd("C:/Users/DELL/Documents/family-income-analysis")
family_data <- readr::read_csv("data/raw/Family Income and Expenditure.csv")

head(family_data)


# Count exact duplicate rows
sum(duplicated(family_data))

# Count all missing cells
sum(is.na(family_data))

# Count missing values in each column
colSums(is.na(family_data))

# Check employment status
family_data %>%
  count(`Household Head Job or Business Indicator`)

# Check whether occupation is missing by employment status
family_data %>%
  group_by(`Household Head Job or Business Indicator`) %>%
  summarise(
    missing_occupation = sum(
      is.na(`Household Head Occupation`)
    ),
    missing_worker_class = sum(
      is.na(`Household Head Class of Worker`)
    ),
    households = n(),
    .groups = "drop"
  )

# Calculate household income statistics
income_summary <- family_data %>%
  summarise(
    total_households = n(),
    average_income = mean(`Total Household Income`),
    median_income = median(`Total Household Income`),
    minimum_income = min(`Total Household Income`),
    maximum_income = max(`Total Household Income`),
    missing_regions = sum(is.na(Region))
  )

print(income_summary)


# Clean education categories
family_data_clean <- family_data %>%
  mutate(
    `Household Head Highest Grade Completed` =
      stringr::str_squish(
        `Household Head Highest Grade Completed`
      ),
    `Household Head Highest Grade Completed` =
      case_when(
        str_to_lower(
          `Household Head Highest Grade Completed`
        ) ==
          "engineering and engineering trades programs" ~
          "Engineering and Engineering Trades Programs",
        TRUE ~ `Household Head Highest Grade Completed`
      )
  )


# Income distribution chart
income_plot <- ggplot(
  family_data_clean,
  aes(x = `Total Household Income`)
) +
  geom_histogram(
    bins = 50,
    fill = "steelblue",
    color = "white"
  ) +
  scale_x_log10(labels = label_comma()) +
  labs(
    title = "Distribution of Household Income",
    subtitle = "Household income shown on a logarithmic scale",
    x = "Household Income (PHP, log scale)",
    y = "Number of Households",
    caption = "Source: Family Income and Expenditure dataset"
  ) +
  theme_minimal()

print(income_plot)

ggsave(
  here("plots/income_distribution.png"),
  plot = income_plot,
  width = 10,
  height = 6,
  dpi = 300
)


# Calculate income by education category
education_income_clean <- family_data_clean %>%
  group_by(`Household Head Highest Grade Completed`) %>%
  summarise(
    households = n(),
    median_income = median(`Total Household Income`),
    average_income = mean(`Total Household Income`),
    .groups = "drop"
  ) %>%
  filter(households >= 100) %>%
  arrange(desc(median_income))

print(education_income_clean)


# Calculate education income chart
education_plot <- ggplot(
  education_income_clean,
  aes(
    x = reorder(
      `Household Head Highest Grade Completed`,
      median_income
    ),
    y = median_income
  )
) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  scale_y_continuous(labels = label_comma()) +
  labs(
    title = "Median Household Income by Education",
    x = "Education Category",
    y = "Median Household Income (PHP)",
    caption = "Source: Family Income and Expenditure dataset"
  ) +
  theme_minimal()

print(education_plot)

ggsave(
  here("plots/education_income.png"),
  plot = education_plot,
  width = 10,
  height = 9,
  dpi = 300
)