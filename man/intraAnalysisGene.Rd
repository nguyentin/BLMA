% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GeneAnalysis.R
\name{intraAnalysisGene}
\alias{intraAnalysisGene}
\title{Intra-experiment analysis of an expression dataset at the gene-level}
\usage{
intraAnalysisGene(data, group, splitSize = 5, metaMethod = addCLT)
}
\arguments{
\item{data}{a data frame where the rows are the gene IDs and the 
columns are the samples}

\item{group}{sample grouping. The elements of \emph{group} are 
either 'c' (control) or 'd' (disease). names(group) should be 
identical to colnames(data)}

\item{splitSize}{the minimum number of disease samples in each split 
dataset. splitSize should be at least 3. By default, splitSize=5}

\item{metaMethod}{the method used to combine p-values. This should be one 
of addCLT (additive method [1]), fishersMethod (Fisher's method [5]), 
stoufferMethod (Stouffer's method [6]), max (maxP method [7]), 
or min (minP method [8])}
}
\value{
A data frame (rownames are gene IDs) that consists of the 
following information:
\itemize{
\item \emph{logFC:} log foldchange (diseases versus controls)
\item \emph{pLimma:} p-value obtained from limma without spliting
\item \emph{pLimma.fdr:} FDR-corrected p-values of pLimma
\item \emph{pIntra:} p-value obtained from intra-experiment analysis
\item \emph{pIntra.fdr:} FDR-corrected p-values of pIntra
}
}
\description{
perform an intra-experiment analysis in conjunction with 
the moderated t-test (limma package) for the purpose of differential 
expression analysis of a gene expression dataset
}
\details{
This function performs an intra-experiment analysis [1] for 
individual genes of the given dataset. The function first splits the 
dataset into smaller datasets, performs a moderated t-test (limma package) 
for the genes of the split datasets, 
and then combines the p-values for individual genes using \emph{metaMethod}
}
\examples{
data(GSE33223)
X <- intraAnalysisGene(data_GSE33223, group_GSE33223)
head(X)

}
\author{
Tin Nguyen and Sorin Draghici
}
\references{
[1] T. Nguyen, R. Tagett, M. Donato, C. Mitrea, and S. Draghici. A novel 
bi-level meta-analysis approach -- applied to biological pathway analysis. 
Bioinformatics, 32(3):409-416, 2016.
}
\seealso{
\code{\link{bilevelAnalysisGene}}, \code{\link{intraAnalysisClassic}}, \code{link{bilevelAnalysisClassic}}
}

