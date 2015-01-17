# tikzsetup

Пакет `tikzsetup` позволяет легко настроить tikz-графику для корректного отображения русских букв в графиках.
Пакет содержит только одну функцию, `tikzsetup()`.

Установить пакет легко:
```r
install.packages("devtools")
devtools::install_github("bdemeshev/tikzsetup")
```


Минимальный Rmd-файл может, например, состоять из двух кусков кода:
```r
library("knitr")
library("tikzsetup")
tikzsetup()
```

А далее строим график с подписями по-русски:
```r
library("ggplot2")
qplot(x=rnorm(100),y=rnorm(100),
  main="Просто график",
  xlab="Абсцисса, $x_t=\\varepsilon_t$", ylab="Ордината, $y_t=\\varepsilon_t$" )
```

Путь к простенькому демо-файлу можно найти командой:
```r
fpath <- system.file("example", "rmd_example.Rmd", package="tikzsetup")
fpath
```