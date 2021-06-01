# Ref: https://www.rdocumentation.org/packages/SentimentAnalysis/versions/1.3-4

# install.packages("SentimentAnalysis")

library(SentimentAnalysis)

# DEMOSTRACIÓN RÁPIDA
# Analyze a single string to obtain a binary response (positive / negative)
sentiment <- analyzeSentiment("Yeah, this was a great soccer game of the German team!")
convertToBinaryResponse(sentiment)$SentimentGI

# PEQUEÑO EJEMPLO
# Create a vector of strings
documents <- c("Wow, I really like the new light sabers!",
               "That book was excellent.",
               "R is a fantastic language.",
               "The service in this restaurant was miserable.",
               "This is neither positive or negative.",
               "The waiter forget about my a dessert -- what a poor service!")

# Analyze sentiment
sentiment <- analyzeSentiment(documents)

# Extract dictionary-based sentiment according to the QDAP dictionary
sentiment$SentimentQDAP

# View sentiment direction (i.e. positive, neutral and negative)
convertToDirection(sentiment$SentimentQDAP)

response <- c(+1, +1, +1, -1, 0, -1)

compareToResponse(sentiment, response)

