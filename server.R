library(shiny)
library(shinyAce)
library(psych)
library(ltm)
library(CTT)
library(eRm)
library(beeswarm)



shinyServer(function(input, output) {


    options(warn=-1)
    
    
    check <- reactive({
        if (input$colname2 == 0) {
            x <- read.table(text=input$text2, sep="\t")
            x <- as.matrix(x)
            
            ans <- read.delim(text=input$text3, sep="\t", fill=TRUE, header=FALSE, stringsAsFactors=FALSE)
            ans <- as.character(ans)
            dat <- score(x, ans, output.scored=TRUE)$scored
            
        } else {
            
            x <- read.csv(text=input$text2, sep="\t")
            
            ans <- read.delim(text=input$text3, sep="\t", fill=TRUE, header=FALSE, stringsAsFactors=FALSE)
            ans <- as.character(ans)
            
            dat <- score(x, ans, output.scored=TRUE)$scored
        }
    })
    
    
    
    bs <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
            
            total <- rowSums(dat, na.rm=T)
            result <- describe(total)[2:13]
            row.names(result) <- "Total   "
            result
        
        } else {
            
            dat <- read.csv(text=input$text1, sep="\t")
            
            total <- rowSums(dat, na.rm=T)
            result <- describe(total)[2:13]
            row.names(result) <- "Total   "
            result
        }
    })
    
    
    
    alpha.result <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
            
        } else {
            dat <- read.csv(text=input$text1, sep="\t")
            
        }
        
        brownRpbi <- function(data,missing) {
            m <- mean(rowSums(data))
            sd <- sd(rowSums(data))
            totalDat <- cbind(data,rowSums(data))
            sortDat <- totalDat[order(-totalDat[,length(totalDat)]),]
            r <- c()
            itemD <- c()
            rownames(sortDat) <- c(1:nrow(sortDat))
            highDat <- head(sortDat,nrow(sortDat) %/% 3)
            lowDat <- tail(sortDat,nrow(sortDat) %/% 3)
            for (i in 1:length(data)) {
                if (is.element(colnames(data)[i], missing) == F ) {
                    mhigh <- mean(subset(totalDat[,length(totalDat)],(data[,i] == 1)))
                    mlow <- mean(subset(totalDat[,length(totalDat)],(data[,i] == 0)))
                    imean <- mean(data[,i])
                    itemD <- c(itemD,round((mean(highDat[,i]) - mean(lowDat[,i])),3))
                    rtemp <- round(cor(data[,i],totalDat[,ncol(totalDat)]),3)
                    r <- c(r,rtemp)
                }
            }
            pbiDF <- data.frame(itemD, r)
            colnames(pbiDF) <- c("ID", "r")
            return(pbiDF)
        }
        
        myAlpha <- function(data) {
            alphaRes <- reliability(data, itemal = T)
            if (length(alphaRes$N_person) == 0) {
                n <- sprintf("%d",alphaRes$nPerson)
                items <- sprintf("%d",alphaRes$nItem)
                mean <- sprintf("%.2f",round(alphaRes$scaleMean,2))
                sd <- sprintf("%.2f",round(alphaRes$scaleSD,2))
                alpha <- substring(sprintf("%.3f",round(alphaRes$alpha,3)),2,5)
            } else {
                n <- sprintf("%d",alphaRes$N_person)
                items <- sprintf("%d",alphaRes$N_item)
                mean <- sprintf("%.2f",round(alphaRes$scale.mean,2))
                sd <- sprintf("%.2f",round(alphaRes$scale.sd,2))
                alpha <- substring(sprintf("%.3f",round(alphaRes$alpha,3)),2,5)
            }
            
            sumStats <- data.frame(Total=c(n,items,alpha))
            rownames(sumStats) <- c("N","Number of items","Cronbach's alpha")
            if (length(alphaRes$N_person) == 0) {
                dropif <- round(ifelse(is.na(alphaRes$alphaIfDeleted),0,alphaRes$alphaIfDeleted),3)
                r.drop <- round(ifelse(is.na(alphaRes$pBis), 0, alphaRes$pBis),3)
                item.mean <- round(alphaRes$itemMean,3)
                itemStats <- data.frame(dropif,r.drop,item.mean)
                rownames(itemStats) <- colnames(data)
            } else {
                dropif <- round(ifelse(is.na(alphaRes$alpha.if.deleted),0,alphaRes$alpha.if.deleted),3)
                r.drop <- round(ifelse(is.na(alphaRes$pbis), 0, alphaRes$pbis),3)
                item.mean <- round(alphaRes$item.mean,3)
                itemStats <- data.frame(dropif,r.drop,item.mean)
                rownames(itemStats) <- attr(alphaRes$item.mean,"names")
            }
            colnames(itemStats) <- c("Drop if","r dropped","IF")
            itemStats2 <- cbind(itemStats,brownRpbi(data,c()))
            itemStats <- itemStats2[,c(1, 2, 5, 3, 4)]
            
            return(list(sumStats,itemStats))
        }
        
        myAlpha(dat)
        
    })
    
    
    
    
    
    data <- reactive({
         if (input$colname == 0) {
             x <- read.table(text=input$text1, sep="\t")
             dat <- as.matrix(x)
             options(digits=3)
             resRM <- RM(dat)
             p.res <- person.parameter(resRM)
             list(rasch = resRM, pp = p.res)
             
         } else {
             dat <- read.csv(text=input$text1, sep="\t")
             options(digits=3)
             resRM <- RM(dat)
             p.res <- person.parameter(resRM)
             list(rasch = resRM, pp = p.res)
         }
    })
    
    
    
    item.est <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
            
            resRM <- data()$rasch
            ciVal <- qnorm(0.975)
            raschTable <- round(data.frame((resRM$betapar * -1), resRM$se.beta,((resRM$betapar*-1)-ciVal*resRM$se.beta),((resRM$betapar*-1)+ciVal*resRM$se.beta)),3)
            colnames(raschTable) <- c("Estimate", "Std. Error", "CI low", "CI high")
            rownames(raschTable) <- colnames(resRM$X)
            print(raschTable)
            
        } else {
            dat <- read.csv(text=input$text1, sep="\t")
            
            resRM <- data()$rasch
            ciVal <- qnorm(0.975)
            raschTable <- round(data.frame((resRM$betapar * -1), resRM$se.beta,((resRM$betapar*-1)-ciVal*resRM$se.beta),((resRM$betapar*-1)+ciVal*resRM$se.beta)),3)
            colnames(raschTable) <- c("Estimate", "Std. Error", "CI low", "CI high")
            rownames(raschTable) <- colnames(resRM$X)
            print(raschTable)
        }
    })
    
    
    
    person.est <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
            
            p.res <- data()$pp
            summary(p.res)
            
        } else {
            dat <- read.csv(text=input$text1, sep="\t")
            
            p.res <- data()$pp
            summary(p.res)
            
        }
    })
    
    
    
    item.fit <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
            
            p.res <- data()$pp
            itemfit(p.res)
            
        } else {
            dat <- read.csv(text=input$text1, sep="\t")
            
            p.res <- data()$pp
            itemfit(p.res)
            
        }
    })
    
    
    
    person.fit <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
            
            p.res <- data()$pp
            personfit(p.res)
            
        } else {
            dat <- read.csv(text=input$text1, sep="\t")
            
            p.res <- data()$pp
            personfit(p.res)
            
        }
    })
    
    
    
    compare <- reactive({
     if (input$compare == 1) {

        if (input$colname == 0) {
            p.res <- data()$pp
            options(digits=3)
            list("Comparison of raw scores and theta" = p.res)

        } else {
            p.res <- data()$pp
            options(digits=3)
            list("Comparison of raw scores and theta" = p.res)
        }
     }
    })
    
    
    
    
    
    makecompPlot <- function(){
        if (input$compare == 1) {
            if (input$colname == 0) {
                p.res <- data()$pp
                plot(p.res)
                
            } else {
                
                dat <- read.csv(text=input$text1, sep="\t")
                p.res <- data()$pp
                plot(p.res)
            }
        }
    }
    
    output$compPlot <- renderPlot({
        print(makecompPlot())
    })





    # Person-Item Map
    
    makepiMap <- function(){
        if (input$map == 1) {
            if (input$colname == 0) {
                resRM <- data()$rasch
                plotPImap(resRM, sorted=TRUE)
                
            } else {
                resRM <- data()$rasch
                plotPImap(resRM, sorted=TRUE)
            }
        }
    }
    
    output$piMap <- renderPlot({
        print(makepiMap())
    })





    # Pathway Map (Bond & Fox, 2001, 2007 参照）
    makepathMap <- function(){
        if (input$path == 1) {
            
            if (input$colname == 0) {
                
                dat <- read.csv(text=input$text1, sep="\t", header=FALSE)
                options(digits=3)
                
                dat <- dat[rowSums(dat) != length(dat),]
                
                resRM <- RM(dat)
                pparm <- person.parameter(resRM)
                plotPWmap(resRM, pp=pparm, pmap=TRUE)
                
            } else {
                
                dat <- read.csv(text=input$text1, sep="\t")
                options(digits=3)
                
                dat <- dat[rowSums(dat) != length(dat),]

                resRM <- RM(dat)
                pparm <- person.parameter(resRM)
                plotPWmap(resRM, pp=pparm, pmap=TRUE)

            }
        }
    }
    
    output$pathMap <- renderPlot({
        print(makepathMap())
    })



    # Item characteristic curves (ICC) Plot
    makeICC <- function(){
        if (input$icc == 1) {
            
            if (input$colname == 0) {
                x <- read.table(text=input$text1, sep="\t")
                dat <- as.matrix(x)
                
                plot.rasch(rasch(dat))
                
            } else {
                
                dat <- read.csv(text=input$text1, sep="\t")
                
                plot.rasch(rasch(dat))
                
            }
        }
    }
    
    output$ICC <- renderPlot({
        print(makeICC())
    })
    
    
    
    
    
    makedistPlot <- function(){
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            x <- as.matrix(x)
            x <- rowSums(x, na.rm=T)
            
            
        } else {
            x <- read.csv(text=input$text1, sep="\t")
            x <- rowSums(x, na.rm=T)
        }
        
        simple.bincount <- function(x, breaks) {
            nx <- length(x)
            nbreaks <- length(breaks)
            counts <- integer(nbreaks - 1)
            for (i in 1:nx) {
                lo <- 1
                hi <- nbreaks
                if (breaks[lo] <= x[i] && x[i] <= breaks[hi]) {
                    while (hi - lo >= 2) {
                        new <- (hi + lo) %/% 2
                        if(x[i] > breaks[new])
                        lo <- new
                        else
                        hi <- new
                    }
                    counts[lo] <- counts[lo] + 1
                }
            }
            return(counts)
        }
        
        nclass <- nclass.FD(x)
        breaks <- pretty(x, nclass)
        counts <- simple.bincount(x, breaks)
        counts.max <- max(counts)
        
        h <- hist(x, las=1, breaks="FD", xlab= "Red vertical line shows the mean.",
        ylim=c(0, counts.max*1.2), main="", col = "cyan")
        rug(x)
        abline(v = mean(x), col = "red", lwd = 2)
        xfit <- seq(min(x), max(x))
        yfit <- dnorm(xfit, mean = mean(x), sd = sd(x))
        yfit <- yfit * diff(h$mids[1:2]) * length(x)
        lines(xfit, yfit, col = "blue", lwd = 2)
        

    }

    output$distPlot <- renderPlot({
        print(makedistPlot())
    })
    
    
    
    
    makeboxPlot <- function(){
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            x <- as.matrix(x)
            x <- rowSums(x, na.rm=T)
            
        } else {
            x <- read.csv(text=input$text1, sep="\t")
            x <- rowSums(x, na.rm=T)
        }
        
        boxplot(x, horizontal=TRUE, xlab= "Mean and +/-1 SD are displayed in red.")
        beeswarm(x, horizontal=TRUE, col = 4, pch = 16, add = TRUE)
        points(mean(x), 0.9, pch = 18, col = "red", cex = 2)
        arrows(mean(x), 0.9, mean(x) + sd(x), length = 0.1, angle = 45, col = "red")
        arrows(mean(x), 0.9, mean(x) - sd(x), length = 0.1, angle = 45, col = "red")
    }
    
    output$boxPlot <- renderPlot({
        print(makeboxPlot())
    })
    
    
    
    
    info <- reactive({
        info1 <- paste("This analysis was conducted with ", strsplit(R.version$version.string, " \\(")[[1]][1], ".", sep = "")# バージョン情報
        info2 <- paste("It was executed on ", date(), ".", sep = "")# 実行日時
        cat(sprintf(info1), "\n")
        cat(sprintf(info2), "\n")
    })
    
    output$info.out <- renderPrint({
        info()
    })





    output$textarea.out <- renderPrint({
        bs()
    })
    
    output$item.est.out <- renderPrint({
       item.est()
    })
    
    output$person.est.out <- renderPrint({
        person.est()
    })
    
    output$item.fit.out <- renderPrint({
        item.fit()
    })
    
    output$person.fit.out <- renderPrint({
        person.fit()
    })
    
    output$alpha.result.out <- renderPrint({
        alpha.result()
    })
    
    output$compare.out <- renderPrint({
       compare()
    })
    
})
