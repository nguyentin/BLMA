% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GeneAnalysis.R
\name{bilevelAnalysisGene}
\alias{bilevelAnalysisGene}
\title{Bi-level meta-analysis of multiple expression datasets at the 
gene-level}
\usage{
bilevelAnalysisGene(dataList, groupList, splitSize = 5, metaMethod = addCLT)
}
\arguments{
\item{dataList}{a list of datasets. Each dataset is a data frame where the 
rows are the gene IDs and the columns are the samples}

\item{groupList}{a list of vectors. Each vector represents the phenotypes 
of the corresponding dataset in dataList, 
which are either 'c' (control) or 'd' (disease).}

\item{splitSize}{the minimum number of disease samples in each split 
dataset. splitSize should be at least 3. By default, splitSize=5}

\item{metaMethod}{the method used to combine p-values. This should be one 
of addCLT (additive method [1]), 
fishersMethod (Fisher's method [5]), stoufferMethod (Stouffer's method [6]), 
max (maxP method [7]), or min (minP method [8])}
}
\value{
A data frame containing the following components:
\itemize{
\item \emph{rownames:} gene IDs that are common in all datasets
\item \emph{pLimma:} the p-values obtained by combining pLimma 
values of individual datasets
\item \emph{pLimma.fdr:} FDR-corrected p-values of pLimma
\item \emph{pBilevel:} the p-values obtained from combining pIntra 
values of individual datasets
\item \emph{pBilevel.fdr:} FDR-corrected p-values of pBilevel
}
}
\description{
Perform a bi-level meta-analysis in conjunction with the 
moderate t-test (limma package) for the purpose of 
differential expression analysis of multiple gene expression datasets
}
\details{
The bi-level framework combines the datasets at two levels: an 
intra- experiment analysis, and an inter-experiment analysis [1]. At the 
intra-experiment analysis, the framework splits a dataset into 
smaller datasets, performs a moderated t-test (limma package) on split 
datasets, and then combines p-values of individual genes 
using \emph{metaMethod}. At the inter-experiment analysis, the p-values 
obtained for each individual datasets are combined using \emph{metaMethod}
}
\examples{
dataSets <- c("GSE17054", "GSE57194", "GSE33223", "GSE42140")
data(list=dataSets, package="BLMA")
names(dataSets) <- dataSets
dataList <- lapply(dataSets, function(dataset) get(paste0("data_", dataset)))
groupList <- lapply(dataSets, function(dataset) get(paste0("group_", dataset)))
Z <- bilevelAnalysisGene(dataList = dataList, groupList = groupList)
head(Z)

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
\code{\link{bilevelAnalysisGene}}, \code{\link{intraAnalysisClassic}}
}

