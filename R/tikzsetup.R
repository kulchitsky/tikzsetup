#' tikzsetup
#'
#' @name tikzsetup
#' @docType package
#' @author Boris Demeshev 
#' @import knitr tikzDevice
NULL

#' Setup tikz device for russian Rmd/Rnw files 
#'
#' Setup tikz device for russian Rmd/Rnw files 
#'
#' Setup tikz device for russian Rmd/Rnw files 
#'
#' @param lang the language
#' @param doc_class_options additional latex document class options 
#' @param message logical, should messages be activated, FALSE by default
#' @param warning logical, should warnings be activated, FALSE by default
#' @export
#' @return nothing
#' @examples
#' tikzsetup()
#' tikzsetup(lang="polish")
tikzsetup  <- function(compiler="pdftex",lang="russian",
                        doc_class_options="10pt",
                        message=FALSE, warning=FALSE) {
  Sys.setenv(LANG="EN") # Error message MUST be in english
  Sys.setlocale("LC_TIME","C") # correct work of quantmod
  
  
  opts_chunk$set(dev='tikz', dpi=300, warning=warning, message=message)
  
  if (compiler=="xelatex") compiler <- "xetex"
  options(tikzDefaultEngine = compiler)
  
  options(tikzLatexPackages = c(
    "\\usepackage{amsmath,amssymb,amsfonts}",
    "\\usepackage{tikz}",
    "\\usepackage[utf8]{inputenc}",
    "\\usetikzlibrary{calc}",
    paste0("\\usepackage[",lang,"]{babel}"),
    paste0("\\selectlanguage{",lang,"}"),
    "\\usepackage{standalone}"
  ))
  
  options(tikzXelatexPackages=c(
    "\\nonstopmode",
    "\\usepackage{tikz}",
    "\\usepackage[active,tightpage,xetex]{preview}",
    "\\PreviewEnvironment{pgfpicture}",
    "\\setlength\\PreviewBorder{0pt}"
  ))
  
  #options(tikzMetricsDictionary="/Users/boris/Documents/r_packages/") # speeds tikz up
  
  options(tikzDocumentDeclaration = 
            paste0("\\documentclass[",doc_class_options,"]{standalone}\n"))
  
  options(tikzMetricPackages = c(
    "\\usepackage[utf8]{inputenc}",
    "\\usetikzlibrary{calc}",
    paste0("\\usepackage[",lang,"]{babel}"),
    paste0("\\selectlanguage{",lang,"}")
  ))
}
