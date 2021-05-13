# Generating Word Cloud in R Programming
# Ref: https://www.geeksforgeeks.org/generating-word-cloud-in-r-programming/

# Step 2: Install and Load the Required Packages
# install the required packages
#install.packages("tm")           # for text mining
#install.packages("SnowballC")    # for text stemming
#install.packages("wordcloud")    # word-cloud generator
#install.packages("RColorBrewer") # color palettes

# load the packages
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Step 3: Text Mining

# Start by importing text file created in step 1:
text = readLines(file.choose())

# Load the data as a corpus:
# VectorSource() function 
# creates a corpus of 
# character vectors
docs = Corpus(VectorSource(text))

# Text transformation:
toSpace = content_transformer (function (x, pattern) gsub(pattern, " ", x))
docs1 = tm_map(docs, toSpace, "/")
docs1 = tm_map(docs, toSpace, "@")
docs1 = tm_map(docs, toSpace, "#")

# Cleaning the Text:
# Convert the text to lower case
docs1 = tm_map(docs1, content_transformer(tolower))

# Remove numbers
docs1 = tm_map(docs1, removeNumbers)

# Remove white spaces
docs1 = tm_map(docs1, stripWhitespace)

# Quitar stop words
docs1 = tm_map(docs1, removeWords, stopwords("english"))
#docs1 = tm_map(docs1, removeWords, c("the", "are", "for", "there", "also", "which"))

# Step 4: Build a term-document Matrix
dtm = TermDocumentMatrix(docs1)
m = as.matrix(dtm)
v = sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)
head(d, 10)

# Step 5: Generate the Word Cloud
wordcloud(words = d$word, 
          freq = d$freq,
          min.freq = 1, 
          max.words = 200,
          random.order = FALSE, 
          rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))

