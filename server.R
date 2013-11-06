library(shiny)
library(shinyAce)
library(psych)
library(ltm)
library(CTT)
library(eRm)


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
            
            result1 <- cronbach.alpha(dat)
            result2 <- alpha(dat, check.keys=F)
            result2 <- round(result2$alpha.drop,3)
            list(result1, "Reliability if the item is dropped/deleted"=result2)
        
        } else {
            dat <- read.csv(text=input$text1, sep="\t")
            
            result1 <- cronbach.alpha(dat)
            result2 <- alpha(dat, check.keys=F)
            result2 <- round(result2$alpha.drop,3)
            list(result1, "Reliability if the item is dropped/deleted"=result2)
        
        }
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
    


    output$compPlot <- renderPlot({
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
    })



    # Person-Item Map
    output$piMap <- renderPlot({
    if (input$map == 1) {
        if (input$colname == 0) {
            resRM <- data()$rasch
            plotPImap(resRM, sorted=TRUE)
        
        } else {
            resRM <- data()$rasch
            plotPImap(resRM, sorted=TRUE)
        }
    }
    })



    # Pathway Map (Bond & Fox, 2001, 2007 参照）
    output$pathMap <- renderPlot({
    if (input$path == 1) {

        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            dat <- as.matrix(x)
        
            res <- PCM(dat)
            pparm <- person.parameter(res)
            plotPWmap(res, pp=pparm, pmap=TRUE)

        } else {
        
            dat <- read.csv(text=input$text1, sep="\t")
        
            res <- PCM(dat)
            pparm <- person.parameter(res)
            plotPWmap(res, pp=pparm, pmap=TRUE)
        
        }
    }
    })



    # Item characteristic curves (ICC) Plot
    output$ICC <- renderPlot({
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
    })






    output$distPlot <- renderPlot({
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

    })
    
    
    
    output$boxPlot <- renderPlot({
        if (input$colname == 0) {
            x <- read.table(text=input$text1, sep="\t")
            x <- as.matrix(x)
            x <- rowSums(x, na.rm=T)
            
        } else {
            x <- read.csv(text=input$text1, sep="\t")
            x <- rowSums(x, na.rm=T)
        }
        
        boxplot(x, horizontal=TRUE, xlab= "Mean and +/-1 SD are displayed in red.")
        stripchart(x, pch = 16, add = TRUE)
        points(mean(x), 0.9, pch = 18, col = "red", cex = 2)
        arrows(mean(x), 0.9, mean(x) + sd(x), length = 0.1, angle = 45, col = "red")
        arrows(mean(x), 0.9, mean(x) - sd(x), length = 0.1, angle = 45, col = "red")
    })







    output$check <- renderTable({
        head(check(), n = 10)
    }, digits = 0)

    output$downloadData <- downloadHandler(
        filename = function() {
            paste('Data-', Sys.Date(), '.csv', sep='')
        },
        content = function(file) {
            write.csv(check(), file)
        }
    )

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
