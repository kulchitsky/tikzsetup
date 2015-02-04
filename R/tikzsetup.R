#' tikzsetup
#'
#' @name tikzsetup
#' @docType package
#' @author Boris Demeshev 
#' @import knitr 
#' @note maybe, sometime... tikzDevice
NULL

#' Setup tikz device for russian Rmd/Rnw files 
#'
#' Setup tikz device for russian Rmd/Rnw files 
#'
#' Setup tikz device for russian Rmd/Rnw files 
#'
#' @param lang the language
#' @param compiler currently pdftex and xelatex are supported
#' @param doc_class_options additional latex document class options 
#' @param message logical, should messages be activated, FALSE by default
#' @param warning logical, should warnings be activated, FALSE by default
#' @param setJustPlot logical, TRUE by default. Sometimes tikzsetup()
#' is called from a big-big document with a bunch of packages which may
#' interfere with tikzsetup(). In this one may use the value true/false
#' of JustPlot macro to load (or not load) some package.
#' @export
#' @return nothing
#' @examples
#' tikzsetup()
tikzsetup  <- function(compiler=c("pdftex","xetex","xelatex","luatex"),lang="russian",
                        doc_class_options=NULL, 
                        message=FALSE, warning=FALSE,
                        setJustPlot = TRUE,
                        pt_size = 12) {

  Sys.setenv(LANG="EN") # Error message MUST be in english! CHECK
  Sys.setlocale("LC_TIME","C") # correct work of quantmod CHECK
  
  # http://stackoverflow.com/questions/15801683/knitr-and-tikzdevice-not-working-together-with-article-options
  
  message("One may conditionally load conflicting packages using the true/false value of JustPlot.")
  
  if(is.null(doc_class_options)) doc_class_options <- paste0(pt_size,"pt,a4paper")
    
  opts_chunk$set(dev='tikz', warning=warning, message=message, dev.args=list(pointsize=pt_size))
  
  compiler <- match.arg(compiler) # magic :)
  if (compiler=="xelatex") compiler <- "xetex"
  options(tikzDefaultEngine = compiler)
  
  options(tikzLatexPackages = c(
    # "\\usepackage{geometry}",
    "\\def\\JustPlot{true}",
    "\\usepackage{amsmath,amssymb,amsfonts}",
    "\\usepackage{tikz}",
    "\\usepackage[utf8]{inputenc}",
    "\\usetikzlibrary{calc}",
    "\\usepackage{standalone}",
    "\\usepackage[babel]{csquotes}",
    "\\MakeOuterQuote{\"}",
    "\\usepackage{etoolbox}",
    "\\ifdef{\\JustPlot}{}{",
    paste0("\\usepackage[",lang,"]{babel}\n"),
    paste0("\\selectlanguage{",lang,"}\n"),
    "}"
  ))

  options(tikzXelatexPackages=c(
    "\\nonstopmode",
    "\\usepackage{tikz}",
    "\\usepackage[active,tightpage,xetex]{preview}",
    "\\PreviewEnvironment{pgfpicture}",
    "\\setlength\\PreviewBorder{0pt}",
    "\\makeatletter",
    "\\@ifpackageloaded{fontspec}{}{\\usepackage{fontspec}}",
    "\\@ifpackageloaded{polyglossia}{}{\\usepackage{polyglossia}}",
    "\\@ifpackageloaded{xunicode}{}{\\usepackage{xunicode}}",
    "\\setmainfont[Mapping=tex-text]{Times New Roman}",
    "\\@ifpackageloaded{xltxtra}{}{\\usepackage{xltxtra}}",
    "\\@ifpackageloaded{xunicode}{}{\\usepackage{xunicode}}",
    "\\newfontfamily\\cyrillicfont[Mapping=tex-text]{Times New Roman}",
    "\\newfontfamily{\\cyrillicfonttt}{Times New Roman}",
    "\\@ifpackageloaded{xecyr}{}{\\usepackage{xecyr}}",
    "\\defaultfontfeatures{Scale=MatchLowercase}",
    "\\makeatother"
  ))

  options(tikzXelatexPackages=c(
    getOption("tikzXelatexPackages"),
    "\\usepackage[babel]{csquotes}",
    "\\MakeOuterQuote{\"}"
    ))
  
  #options(tikzMetricsDictionary="/Users/boris/Documents/r_packages/") # speeds tikz up
  
  options(tikzDocumentDeclaration = 
            paste0("\\documentclass[",doc_class_options,"]{standalone}\n")) # book will not work
  
  options(tikzMetricPackages = c(
    "\\usepackage[utf8]{inputenc}",
    "\\usetikzlibrary{calc}", 
    paste0("\\usepackage[",lang,"]{babel}"),
    paste0("\\selectlanguage{",lang,"}")
  ))
}

#' Lanch this function after installation of the tikzsetup.
#' This should be done in clear R, when all packages are unloaded.
#' 
#' @export
#' @return nothing
#' @examples
#' tikzmagic()

tikzmagic <- function() {
  if (!("devtools" %in% installed.packages())) install.packages("devtools")
  library(devtools)
  if ("filehash" %in% installed.packages()) remove.packages("filehash")
  library(devtools)
  install_github("rdpeng/filehash",ref="next")
  if ("tikzDevice" %in% installed.packages()) remove.packages("tikzDevice")
  install_github("kulchitsky/tikzDevice")
}