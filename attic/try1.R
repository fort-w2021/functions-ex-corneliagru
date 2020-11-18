library(checkmate)


# a -----------------------------------------------------------------------


# i don't see a problem here? maybe:
set.seed(seed = 20141012)

# wrong order and not explicitly named
x <- sample(x = c(1:10, NA), size = 20, replace = TRUE)

# wrong order maybe remove min and max since default values are used
y <- runif(n = 20, min = 0, max = 1)
y <- runif(n = 20)


# argument names not correctly and remove abbreviation for clarity
cor(x = x, y = y, use = "pairwise.complete.obs", method = "kendall")




# b ---------------------------------------------------

# lazy evaluation

# the function returns 3 because of R's principle of lazy evaluation. For the
# calculation of x + y it first tries to find the 'x' which assigns y the value
# 1 and returns 2. Since 'y' got the value 1 the sum of x and y is 3.

f1 <- function(
               x =
                 {
                   y <- 1
                   2
                 },
               y = 0)
{
  x + y
}


f1()


# Here on the otherhand y is evaluated first, which is a function argument and
# has the value 0. X is evaluatel later and has the value of 2. Therfore 0 + 2 =
# 2

f1a <- function(x =
                  {
                    y <- 1
                    2
                  },
                y = 0)
{
  y + x
}

f1a()



# Here you can see the "evaluation workflow". Fist R searches for the y = 0,
# then for the x = 2, which changes y to 1.

f1b <- function(x =
                  {
                    y <- 1
                    2
                  },
                y = 0)
{
  c(y, x, y)
}

f1b()


# c -----------------------------------------------------------------------

f2 <- function(x = z) {
  z <- 100
  x
}

f2()


# d -----------------------------------------------------------------------

# Schreiben sie eine infix-Funktion %xor% für logical-inputs die eine
# XOR-Operation (entweder-oder-aber-nicht-beides) durchführt. Überprüfen Sie
# ihre Funktion mit den folgenden Tests:



# infix function for the logical xor operation
`%xor%` <- function(x, y) {
  assert_logical(x)
  assert_logical(y)

  xor(x, y)
}

# i could of course also copy the r-base function code

`%xor%` <- function(x, y) {
  assert_logical(x)
  assert_logical(y)

  (x | y) & !(x & y)
}





# e -----------------------------------------------------------------------

# Wie kann jeweils der Zustand von options() und par() abgespeichert und
# wiederhergestellt werden?


old_par <- par()
par(mfrow = c(1, 2))
plot(1:10)
plot(2:12)
par(old_par)
plot(1:10)

# or in case par is changed within a function you can use
on.exit(par(old_par))


# same for options

old_options <- options()

# do some changes

options(old_options)

# f -----------------------------------------------------------------------

# Schreiben Sie eine Funktion die ein neues PDF-Grafikdevice öffnet, plot mit
# den übergebenen Argumenten aufruft und dann das zuvor geöffnete Grafikfenster
# wieder schließt, egal ob die übergebenen Argumente für plot funktioniert haben
# oder nicht.




# a function that opens an pdf window, plots the given arguments and closes the
# window again. plot will be saved in current working directory
plot_pdf <- function(pdf_args = NULL, plot_args = NULL) {
  assert_list(plot_args, all.missing = FALSE)

  if (is.null(pdf_args)) {
    pdf()
  } else {
    do.call(pdf, pdf_args)
  }

  do.call(plot, plot_args)
  dev.off()
}

plot_pdf(plot_args = list(x = 1:10, y = rnorm(10)))

plot_pdf()


plot(1:10)
dev.off()
# g -----------------------------------------------------------------------

# Was gibt der folgende Code zurück? Warum? Was bedeuten die drei verschiedenen
# cs in der zweiten Zeile?

c <- 10
c(c = c)

# c(name = value)
# the first c calls the function c() which combines values into vectors or lists
# the second c is the name of the object
# the third c is the value which the vector will have
