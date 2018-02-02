Live code from purrr session at rstudio::conf
================
Jenny Bryan
2018-02-01

Where to find this document
---------------------------

Shortlink humans can type:

-   <http://bit.ly/jenny-live-code>

Horrible link that reveals how this is done:

-   <https://www.dropbox.com/s/2b8mi4rir23pvnx/jenny-live-code.R?raw=1>

Using the `raw=1` query trick for rendering a DropBox-hosted file in the browser:

-   <https://www.dropbox.com/en/help/desktop-web/force-download> learned from [Michael Levy](https://twitter.com/ucdlevy).

How this works:

-   I code live in an R script locally. I save often.
-   This file lives in a directory synced to DropBox.
-   You open the DropBox file at <http://bit.ly/jenny-live-code> and refresh as needed.
-   Should allow you to see, copy, paste everything I've typed and save the entire transcript at the end. This file is highly perishable, so save your own copy if you want it.
-   Every now and then the refresh won't work. Just re-open from from the bit.ly link: <http://bit.ly/jenny-live-code>

Workshop material starts here
-----------------------------

``` r
library(tidyverse) ## includes purrr, which is our main attraction today
## -- Attaching packages ----------------------------------------------- tidyverse 1.2.1 --
## v ggplot2 2.2.1     v purrr   0.2.4
## v tibble  1.4.2     v dplyr   0.7.4
## v tidyr   0.7.2     v stringr 1.2.0
## v readr   1.1.1     v forcats 0.2.0
## -- Conflicts -------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
library(repurrrsive)
## Error in library(repurrrsive): there is no package called 'repurrrsive'

## Completely frivolous playing around with different idioms
## for iteration
## Will wake everyone up and focus on ITERATION!

## https://github.com/brooke-watson/BRRR
## devtools::install_github("brooke-watson/BRRR")
library(BRRR)
## Error in library(BRRR): there is no package called 'BRRR'

skrrrahh(2)
## Error in skrrrahh(2): could not find function "skrrrahh"
skrrrahh(35)
## Error in skrrrahh(35): could not find function "skrrrahh"
skrrrahh("bigsean5")
## Error in skrrrahh("bigsean5"): could not find function "skrrrahh"

for(i in 1:5) {
  Sys.sleep(0.75)
  skrrrahh(i)
}
## Error in skrrrahh(i): could not find function "skrrrahh"

walk(1:5, ~{Sys.sleep(0.75); BRRR::skrrrahh(.x)})
## Error in loadNamespace(name): there is no package called 'BRRR'

f <- function(sound, sleep = 0.75) {
  Sys.sleep(sleep)
  skrrrahh(sound)
}

walk(30:35, f)
## Error in skrrrahh(sound): could not find function "skrrrahh"

## Hello Game of Thrones characters + list inspection ----

?got_chars
## No documentation for 'got_chars' in specified packages and libraries:
## you could try '??got_chars'

# ick
str(got_chars)
## Error in str(got_chars): object 'got_chars' not found

View(got_chars)
## Error in as.data.frame(x): object 'got_chars' not found
# use the object viewer and it's code generation to get ...
got_chars[[9]][["name"]]
## Error in eval(expr, envir, enclos): object 'got_chars' not found

# take more control of str()
str(got_chars[[9]])
## Error in str(got_chars[[9]]): object 'got_chars' not found
str(got_chars, max.level = 1)
## Error in str(got_chars, max.level = 1): object 'got_chars' not found
str(got_chars, list.len = 3)
## Error in str(got_chars, list.len = 3): object 'got_chars' not found

## revisit slides to introduce map() and map_*() friends

## Shortcuts to get elements by name or position ----

## map(YOUR_LIST, YOUR_FUNCTION)
## map(YOUR_LIST, STRING)
## map(YOUR_LIST, INTEGER)

map(got_chars, "name")
## Error in map(got_chars, "name"): object 'got_chars' not found
map(got_chars, 3)
## Error in map(got_chars, 3): object 'got_chars' not found

## this is how we would do in base (vs. purrr)
lapply(got_chars, function(x) x[["name"]])
## Error in lapply(got_chars, function(x) x[["name"]]): object 'got_chars' not found
lapply(got_chars, function(x) x[[3]])
## Error in lapply(got_chars, function(x) x[[3]]): object 'got_chars' not found

## Exercises

## Use names() to get the names of the list elements associated with a single
## character.
## What's the position of the "playedBy" element?
## Use string and position shortcuts to extract playedBy for all characters.

## Type-specific map w/ string or position shortcuts ----
map_chr(got_chars, "name")
## Error in map_chr(got_chars, "name"): object 'got_chars' not found
## there's also map_int(), map_lgl(), map_dbl()

## Exercises

## Get an integer vector of character "id"s, using the string shortcut.

## Get the same integer vector again, using the integer position shortcut.

## Get the same vector again, using map() and then flatten_int()

## Inspect the info for one specific character (just pick one).
## Which element is logical?
## What's its name?
## What's its position?
## Use map_lgl() to get a logical vector of these across all characters.

## Extract multiple things ----
got_chars[[3]][c("name", "culture", "gender", "born")]
## Error in eval(expr, envir, enclos): object 'got_chars' not found

x <- map(got_chars, `[`, c("name", "culture", "gender", "born"))
## Error in map(got_chars, `[`, c("name", "culture", "gender", "born")): object 'got_chars' not found
x
## Error in eval(expr, envir, enclos): object 'x' not found
View(x)
## Error in as.data.frame(x): object 'x' not found

## Inspect the info for one specific character (just pick one).
## What's the integer position of these elements:
## "name", "gender", "culture", "born", and "died".
## Map `[` over characters by INTEGER POSITIONS instead of name.

## Extract multiple things into data frame rows ----
map_dfr(got_chars, `[`, c("name", "culture", "gender", "id", "born", "alive"))
## Error in map(.x, .f, ...): object 'got_chars' not found

## Try to do similar with "name" and "titles".
## What happens? Why? Can you think of another way to get that job done?

## go back to slides to remind ourselves .f can be more general

## Beyond the string and integer shortcut ----

## modelling a development workflow ----
library(glue)
## 
## Attaching package: 'glue'
## The following object is masked from 'package:dplyr':
## 
##     collapse

## practice with a fake, simple example you control
glue_data(
  list(name = "Jenny", born = "in Atlanta"),
  "{name} was born {born}."
)
## Jenny was born in Atlanta.

## practice with a real example in your data
glue_data(got_chars[[2]], "{name} was born {born}.")
## Error in glue_data(got_chars[[2]], "{name} was born {born}."): object 'got_chars' not found

## practice with a real, different example in your data
glue_data(got_chars[[9]], "{name} was born {born}.")
## Error in glue_data(got_chars[[9]], "{name} was born {born}."): object 'got_chars' not found

## drop this code into map()
map(got_chars, ~ glue_data(.x, "{name} was born {born}."))
## Error in map(got_chars, ~glue_data(.x, "{name} was born {born}.")): object 'got_chars' not found

## use the simplifying form map_chr()
map_chr(got_chars, ~ glue_data(.x, "{name} was born {born}."))
## Error in map_chr(got_chars, ~glue_data(.x, "{name} was born {born}.")): object 'got_chars' not found

## end workflow modelling

## All the ways to specify .f ----
aliases <- set_names(
  map(got_chars, "aliases"),
  map_chr(got_chars, "name")
)
## Error in map(got_chars, "aliases"): object 'got_chars' not found
(aliases <- aliases[c(1, 13, 17)])
## Error in eval(expr, envir, enclos): object 'aliases' not found

## map(YOUR_LIST, YOUR_FUNCTION)

## .f = a pre-existing function (custom, in this case)
my_fun <- function(x) paste(x, collapse = " | ")
map(aliases, my_fun)
## Error in map(aliases, my_fun): object 'aliases' not found

## .f = anonymous function
map(aliases, function(x) paste(x, collapse = " | "))
## Error in map(aliases, function(x) paste(x, collapse = " | ")): object 'aliases' not found

## .f = pre-existing function, with extra args passed through `...`
map(aliases, paste, collapse = " | ")
## Error in map(aliases, paste, collapse = " | "): object 'aliases' not found

## .f = anonymous function, via a ~ formula
map(aliases, ~ paste(.x, collapse = " | "))
## Error in map(aliases, ~paste(.x, collapse = " | ")): object 'aliases' not found

## Exercises

## Each character can be allied with one of the houses (or with several or with
## zero). These allegiances are held as a vector in each character’s component.

## Create a list of allegiances that holds the characters’ house affiliations.
allegiances <- map(got_chars, "allegiances")
## Error in map(got_chars, "allegiances"): object 'got_chars' not found
## Create a character vector nms that holds the characters’ names.
nms <- map_chr(got_chars, "name")
## Error in map_chr(got_chars, "name"): object 'got_chars' not found
## Apply the names in nms to the allegiances list via set_names.
names(allegiances) <- nms
## Error in eval(expr, envir, enclos): object 'nms' not found
##
## how many allegiances does each character have?
map_int(allegiances, length)
## Error in map_int(allegiances, length): object 'allegiances' not found
##
## Form a logical vector that reports if this character is allied with House Targaryen.
map_lgl(allegiances, ~ any(grepl("Targaryen", .x)))
## Error in map_lgl(allegiances, ~any(grepl("Targaryen", .x))): object 'allegiances' not found

## go back to slides for some visual inspiration about map2() and pmap()
## (no code examples here, but they do come up in real life)
## also intro to putting lists in a data frame

## list-columns = lists in a data frame ----
gt <- tibble(
  name = map_chr(got_chars, "name"),
  houses = map(got_chars, "allegiances")
)
## Error in map_chr(got_chars, "name"): object 'got_chars' not found
View(gt)
## Error in as.data.frame(x): object 'gt' not found

## KEY IDEA: use map() inside tibble(), mutate(), filter(), etc.

## sidebar: revel in enframe <--> deframe
## named list <--> two column tibble
gt
## Error in eval(expr, envir, enclos): object 'gt' not found
deframe(gt)
## Error in deframe(gt): object 'gt' not found
enframe(deframe(gt))
## Error in deframe(gt): object 'gt' not found

gt %>%
  mutate(n_houses = map_int(houses,length)) %>%
  filter(n_houses > 1) %>%
  unnest()
## Error in eval(lhs, parent, parent): object 'gt' not found

## Exercises

## Make a tibble that has 1 variable, stuff, that is got_chars:
df <- tibble(
  stuff = got_chars
)
## Error in overscope_eval_next(overscope, expr): object 'got_chars' not found

## Create 3 new, regular variables in this data frame that are
## simple atomic vectors by extracting and/or computing on the
## stuff in the list. Ideas:
##   * name is a great variable to have!
##   * Other good simple character variables: culture, playedBy
##   * id is a simple integer candidate, but boring/meaningless
##   * A character list-column could be made from titles, aliases,
##     allegiances, povBooks.
##   * An integer vector can be made by taking length of ^^ above.
##   * Get rid of the list-column(s) and admire your new data frame
```
