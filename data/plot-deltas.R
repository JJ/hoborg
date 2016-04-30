library("ggplot2")
hoborg.data <- read.csv('manny-data.csv')
hoborg.data.Test <- hoborg.data$Tests
hoborg.data.Test.plus1 <- rep(NA,length(hoborg.data.Test+1))
hoborg.data.Test.plus1[1] <- 0
hoborg.data.Test.plus1[2:length(hoborg.data.Test.plus1)] <- hoborg.data.Test[1:(length(hoborg.data.Test) -1 )]
hoborg.diffs <- hoborg.data.Test - hoborg.data.Test.plus1
