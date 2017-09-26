slots <- read.csv("slots.csv", stringsAsFactors = FALSE)

# Windows should be a matrix with a column for each window
calculate_prize_v <- function(windows) {
  payoffs <- c("DD" = 800, "7" = 80, "BBB" = 40, 
    "BB" = 25, "B" = 10, "C" = 10, "0" = 0)

  prize <- rep(NA, nrow(windows))

  same <- windows[, 1] == windows[, 2] & windows[, 2] == windows[, 3]
  prize[same] <- payoffs[windows[same, 1]]
  
  bars <- windows == "B" | windows ==  "BB" | windows == "BBB"
  all_bars <- bars[, 1] & bars[, 2] & bars[, 3]  
  prize[all_bars] <- 5

  other <- !same & !all_bars
  other_windows <- windows[other, ]
  cherries <- rowSums(other_windows == "C")
  diamonds <- rowSums(other_windows == "DD")
  prize[other] <- c(0, 2, 5)[cherries + 1] * 
    c(1, 2, 4)[diamonds + 1]

  unname(prize)
}

play_many <- function(n) {
  w1 <- sample(slots$w1, n, rep = T)
  w2 <- sample(slots$w2, n, rep = T)
  w3 <- sample(slots$w3, n, rep = T)
  
  calculate_prize_v(cbind(w1, w2, w3))
}
