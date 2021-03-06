% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PathwayAnalysis.R
\name{bilevelAnalysisGeneset}
\alias{bilevelAnalysisGeneset}
\title{Bi-level meta-analysis -- applied to geneset enrichment analysis}
\usage{
bilevelAnalysisGeneset(gslist, gs.names, dataList, groupList, splitSize = 5,
  metaMethod = addCLT, enrichment = "ORA", pCutoff = 0.05,
  percent = 0.05, mc.cores = 1, ...)
}
\arguments{
\item{gslist}{a list of gene sets.}

\item{gs.names}{names of the gene sets.}

\item{dataList}{a list of datasets to be combined. Each dataset is a 
data frame where the rows are the gene IDs and the columns are the samples.}

\item{groupList}{a list of vectors. Each vector represents the phenotypes 
of the corresponding dataset in dataList. 
The elements of each vector are either 'c' (control) or 'd' (disease).}

\item{splitSize}{the minimum number of disease samples in each split 
dataset. splitSize should be at least 3. By default, splitSize=5}

\item{metaMethod}{the method used to combine p-values. This should be one 
of addCLT (additive method [1]), fisherMethod (Fisher's method [5]), 
stoufferMethod (Stouffer's method [6]), max (maxP method [7]), 
or min (minP method [8])}

\item{enrichment}{the method used for enrichment analysis. This should be 
one of "ORA", "GSA", or "PADOG". By default, enrichment is set to "ORA".}

\item{pCutoff}{cutoff p-value used to identify differentially 
expressed (DE) genes. This parameter is used only when the enrichment 
method is "ORA". By default, pCutoff=0.05 (five percent)}

\item{percent}{percentage of genes with highest foldchange to be considered 
as differentially expressed (DE). This parameter is used when the 
enrichment method is "ORA". By default percent=0.05 (five percent). Please 
note that only genes with p-value less than pCutoff will be considered}

\item{mc.cores}{the number of cores to be used in parallel computing. 
By default, mc.cores=1}

\item{...}{additional parameters of the GSA/PADOG functions}
}
\value{
A data frame (rownames are geneset/pathway IDs) that consists of the 
following information:
\itemize{
\item \emph{Name:} name/description of the corresponding pathway/geneset
\item Columns that include the pvalues obtained from the intra-experiment 
analysis of individual datasets
\item \emph{pBLMA:} p-value obtained from the inter-experiment analysis 
using addCLT
\item \emph{rBLMA:} ranking of the geneset/pathway using addCLT
\item \emph{pBLMA.fdr:} FDR-corrected p-values
}
}
\description{
Perform a bi-level meta-analysis in conjunction with 
geneset enrichment methods (ORA/GSA/PADOG) to integrate 
multiple gene expression datasets.
}
\details{
The bi-level framework combines the datasets at two levels: 
an intra- experiment analysis, and an inter-experiment analysis [1]. At the 
intra-level analysis, the framework splits a dataset into smaller datasets, 
performs enrichment analysis for each split dataset (using ORA [2], 
GSA [3], or PADOG [4]), and then combines the results of these split 
datasets using \emph{metaMethod}. At the inter-level analysis, the results 
obtained for individual datasets are combined using \emph{metaMethod}
}
\examples{
# load KEGG pathways and create gene sets
x <- loadKEGGPathways()
gslist <- lapply(x$kpg,FUN=function(y){return (nodes(y));})
gs.names <- x$kpn[names(gslist)]

# load example data
dataSets <- c("GSE17054", "GSE57194", "GSE33223", "GSE42140")
data(list=dataSets, package="BLMA")
names(dataSets) <- dataSets
dataList <- lapply(dataSets, function(dataset) get(paste0("data_", dataset)))
groupList <- lapply(dataSets, function(dataset) get(paste0("group_", dataset)))
# perform bi-level meta-analysis in conjunction with ORA
ORAComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList, groupList, enrichment = "ORA")
head(ORAComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

# perform bi-level meta-analysis in conjunction with GSA
GSAComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList, groupList, enrichment = "GSA", nperms = 200, random.seed = 1)
head(GSAComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

# perform bi-level meta-analysi in conjunction with PADOG
set.seed(1)
PADOGComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList, groupList, enrichment = "PADOG", NI=200)
head(PADOGComb[, c("Name", "pBLMA", "pBLMA.fdr", "rBLMA")])

}
\author{
Tin Nguyen and Sorin Draghici
}
\references{
[1] T. Nguyen, R. Tagett, M. Donato, C. Mitrea, and S. Draghici. A novel 
bi-level meta-analysis approach -- applied to biological pathway analysis. 
Bioinformatics, 32(3):409-416, 2016.

[2] S. Draghici, P. Khatri, R. P. Martin, G. C. Ostermeier, and 
S. A. Krawetz. Global functional profiling of gene expression. 
Genomics, 81(2):98-104, 2003.

[3] B. Efron and R. Tibshirani. On testing the significance of sets of 
genes. The Annals of Applied Statistics, 1(1):107-129, 2007.

[4] A. L. Tarca, S. Draghici, G. Bhatti, and R. Romero. Down-weighting 
overlapping genes improves gene set analysis. 
BMC Bioinformatics, 13(1):136, 2012.

[5] R. A. Fisher. Statistical methods for research workers. 
Oliver & Boyd, Edinburgh, 1925.

[6] S. Stouffer, E. Suchman, L. DeVinney, S. Star, and J. Williams, RM. 
The American Soldier: Adjustment during army life, volume 1. 
Princeton University Press, Princeton, 1949.

[7] L. H. C. Tippett. The methods of statistics. 
The Methods of Statistics, 1931.

[8] B. Wilkinson. A statistical consideration in psychological research. 
Psychological Bulletin, 48(2):156, 1951.
}
\seealso{
\code{\link{bilevelAnalysisPathway}}, \code{\link{phyper}}, \code{\link{GSA}}, \code{\link{padog}}
}

