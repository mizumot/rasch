library(shiny)
library(shinyAce)


shinyUI(bootstrapPage(

    headerPanel("Rasch Model (1PL IRT)"),


########## Adding loading message #########

tags$head(tags$style(type="text/css", "
#loadmessage {
position: fixed;
top: 0px;
left: 0px;
width: 100%;
padding: 10px 0px 10px 0px;
text-align: center;
font-weight: bold;
font-size: 100%;
color: #000000;
background-color: #CCFF66;
z-index: 105;
}
")),

conditionalPanel(condition="$('html').hasClass('shiny-busy')",
tags$div("Loading...",id="loadmessage")),

########## Added up untill here ##########


    mainPanel(
        tabsetPanel(


        tabPanel("Main",

        strong('Option:'),

        checkboxInput("colname", label = "The input data includes variable names (the header) in the first row.", TRUE),

        br(),

        p('Note: Input values (either numeric or character) must be separated by tabs. Copy and paste from Excel/Numbers.'),

        aceEditor("text1", value="Q01\tQ02\tQ03\tQ04\tQ05\tQ06\tQ07\tQ08\tQ09\tQ10\tQ11\tQ12\tQ13\tQ14\tQ15\tQ16\tQ17\tQ18\tQ19\tQ20\tQ21\tQ22\tQ23\tQ24\tQ25\tQ26\tQ27\tQ28\tQ29\tQ30\tQ31\tQ32\tQ33\tQ34\tQ35\tQ36\tQ37\tQ38\tQ39\tQ40\tQ41\tQ42\tQ43\tQ44\tQ45\tQ46\tQ47\tQ48\tQ49\tQ50\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t1\t1\t0\t0\t1\t0\t0\t0\t0\t1\t0\t0\t1\t0\t1\t0\t0\t0\t1\t1\t1\t0\t0\t0\t0\t0\n1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t0\t0\t0\t0\t0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t0\t0\n1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t0\t1\t1\t0\t0\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\n0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t0\t1\t0\t0\t0\t0\t0\t0\t0\n0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t0\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t0\t0\t1\t0\t1\t0\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t0\t0\t1\n0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t0\t0\t0\t0\t0\t1\t0\t0\t1\t1\t1\t0\t0\t0\t1\t1\t1\t0\t0\t0\t0\t0\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t0\t0\t0\t0\t1\t0\t0\t1\t0\t1\t1\t0\t0\t1\t0\t0\t0\t0\t1\n0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t0\t1\t1\t0\t1\t1\t1\t0\t0\t0\t1\t0\t1\t1\t1\t0\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t0\t0\t0\t1\t1\t1\t1\t1\t0\t0\t0\t0\t1\t0\t1\t0\t0\t1\t1\t0\t1\t0\n1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t0\t1\t1\t1\t1\t1\t1\n0\t0\t0\t1\t0\t0\t1\t0\t0\t1\t0\t0\t1\t1\t0\t1\t1\t0\t0\t0\t1\t1\t0\t1\t1\t1\t1\t0\t0\t0\t1\t0\t0\t0\t0\t0\t1\t0\t0\t0\t0\t0\t0\t0\t1\t1\t0\t1\t0\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t1\t0\t1\t0\t1\t0\t0\t0\t0\t1\t1\t1\t0\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\n0\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t0\t0\t1\t1\t1\t0\t0\t0\t0\t1\t0\t1\t1\t0\t0\t0\t0\t1\t0\t0\t0\t0\t1\t0\t0\t1\t1\t0\t0\t1\t0\t0\t0\t0\t1\t0\t0\n1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t0\t0\t1\t0\t0\t1\t1\t1\t0\t0\t1\t0\t0\t0\t1\t0\t1\t1\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t0\t0\t1\t0\t0\t0\t0\t1\t0\t1\t1\t0\t0\t0\t1\t0\t1\t1\t1\t1\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t0\t0\t0\t0\t1\t0\t1\t1\t1\t0\t1\t0\t1\t1\t0\t0\t1\t1\t1\t0\t0\t0\n0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t0\t0\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t0\t0\t1\t1\t0\t1\t1\n1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t0\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t0\t1\t0\t0\t0\t0\t1\t0\t0\t1\t1\t0\t1\t1\t1\t1\t1\t0\t0\t0\t1\t0\t0\t0\n0\t1\t0\t1\t0\t0\t1\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t0\t0\t1\t0\t1\t1\t0\t0\t0\t1\t0\t1\t0\t1\t0\t0\t0\t0\t0\t1\t0\t0\t0\t0\t1\t1\t0\t0\t0\t0\t0\t0\t0\n0\t1\t0\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t1\t0\t0\t0\t0\t1\t0\t1\t1\t0\t0\t1\t1\t1\t0\t0\t1\t0\t0\t0\t0\t1\t0\t0\t0\n1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t0\t0\t0\t0\t1\t0\t0\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t0\t1\t1\t0\t1\t0\t0\t0\t0\t0\t0\t1\t0\t1\t1\t0\t1\t1\t0\t0\t0\t1\t1\t0\t0\t0\n0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t0\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\n0\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t1\t0\t0\t0\t0\t0\t0\t0\t0\t1\t0\t1\t1\t1\t1\t0\t1\t0\t0\t0\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t0\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t0\t1\t0\t0\t0\t0\t0\t1\t1\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t0\t0\t0\t1\t0\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\n1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t0\t0\t1\t1\t0\t0\t1\t0\t1\t0\t0\t0\t1\t1\t1\t1\t0\t0\n1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t0\t1\t0\t0\t1\t1\n0\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t0\t0\t0\t1\t1\t0\t0\t1\t0\t0\t0\t1\t0\t1\t1\t0\t0\t1\t0\t1\t0\t1\t0\t1\t1\t0\t1\t1\t1\n0\t1\t0\t0\t1\t1\t1\t1\t1\t0\t0\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t0\t0\t1\t0\t0\t0\t1\t1\t0\t0\t1\t0\t1\t0\t1\t0\t1\t0\t0\t0\t0\t0\t0\t0\n0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t1\t1\t0\t0\t0\t1\t0\t0\t1\t1\t0\t0\t0\t1\t0\t1\t0\t0\t1\t0\t0\t0\t0\t1\t1\n0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t0\t0\t1\t1\t1\t0\t1\t1\t1\t0\t0\t0\t0\t0\t1\t1\t0\t1\n1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t0\t1\t0\t0\t0\t1\t0\t1\t0\t1\t0\t0\t1\t0\t0\t1\t1\t1\t0\t1\n1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t0\t1\t1\t1\t0\t1\t1\t0\t0\t0\t1\t0\t0\t1\t0\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t0\t0\n1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t1\t1\t0\t1\t0\t0\t0\t0\t0\t1\t1\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t0\t1\t1\t0\t0\t0\t1\t1\t1\t0\t1\t0\t0\t1\t0\t0\t0\t0\t0\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t1\t0\t1\t1\t0\t1\t0\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t0\t1\t1\t0\t1\t0\t0\t1\t0\t1\t1\t0\t0\t1\t0\t0\t1\t1\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t0\t1\t1\t0\t0\t1\t1\t1\t0\t1\t0\t0\t0\t0\t0\t0\t1\t1\t0\t0\t1\n0\t1\t1\t0\t1\t0\t1\t0\t0\t0\t0\t1\t1\t0\t1\t1\t1\t1\t0\t0\t1\t0\t0\t1\t0\t1\t1\t0\t0\t0\t0\t0\t0\t1\t0\t1\t0\t0\t1\t0\t0\t0\t0\t0\t0\t0\t1\t0\t1\t1\n1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t1\t0\t1\t0\t0\t1\t1\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t0\t0\t0\t0\t1\t0\t0\t0\t0\t1\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t0\t1\t0\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t1\t0\t0\t0\t1\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t0\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t1\t1\t0\t0\t1\t1\t0\t0\t1\t0\t0\t0\t0\t1\t0\t0\t1\t0\t1\t0\t0\t0\t0\t0\t0\t1\t0\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t0\t0\t1\t1\t0\t0\t1\t0\t1\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\n1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t1\t0\t1\t0\t0\t1\t1\t0\t0\t1\t1\t1\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t0\t1\t1\t1\t1\t0\t1\t1\t0\t1\t0\t1\t1\t0\t0\t1\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t0\t0\n1\t1\t0\t0\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t0\t0\t0\t0\t1\t1\t0\t1\t0\t0\t0\t0\t1\t0\t1\t0\t1\t0\t0\t1\t1\t0\t0\t1\n0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t0\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t0\t1\t1\t0\t0\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\n1\t1\t0\t0\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t0\t0\t1\t1\t0\t0\t0\t1\t0\t1\t0\t0\t0\t1\t0\t0\t1\t0\t0\n1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t0\t0\t1\t0\t1\t1\t0\t1\t0\t1\t1\t1\t1\t0\t0\t0\t1\t1\t0\t1\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t0\t0\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t0\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t1\t0\n0\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t0\t0\t0\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t1\t1\t0\t0\t1\t1\n1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t0\t1\t0\t1\t0\t1\t1\t1\t0\t1\t0\t0\t0\t0\t0\t1\t0\t0\t0\t1\t1\t1\t0\t0\t1\t1\t0\t0\t0\t0\t0\n0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t0\t0\t0\t1\t1\t1\t1\t1\t1\t0\t0\t1\t0\t1\t1\t1\t1\t0\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t0\t0\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t0\t1\t1\t0\t0\t0\n1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t1\t0\t0\t1\t1\t1\t1\t0\t1\t0\t0\t1\n0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t0\t0\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t1\t0\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t1\t0\t1\t1\t1\t0\t0\t1\t0\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t0\t1\t0\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t1\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t0\t1\t0\t0\t1\t1\t1\t1\t1\t0\t1\t0\t0\t0\t1\t0\t1\t1\t1\t0\t1\t0\t0\t1\t1\t0\t1\t1\t0\t1\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\n1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t0\t0\t0\t0\t0\t0\t1\t1\t1\t0\t1\t0\t0\t0\t0\t1\t1\t1\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t0\t1\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t0\t0\t1\t1\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t0\t1\t0\t1\t0\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t0\t0\t0\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t0\n1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t1\t0\t1\t0\t0\t1\t0\t0\t0\t0\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t0\t1\t0\t1\t0\t1\t1\t1\t1\t1\t1\t1\t0\t1\t0\t1\t1\t1\t0\t0\t1\n1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t1\t1\t1\t0\t1\t0\t0\t1\t0\t1\t1\t1\t1\t1\t0\t1\t0\t1\t0\t1\t0\t0\t1\t1\t0\t1\t1\n1\t1\t1\t1\t1\t0\t0\t0\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t1\t0\t0\t1\t1\t0\t1\t0\t0\t0\t0\t0\t0\t0\t0\t1\t1\t1\t1\t1\t0\t0\t1\t0\t0\t0\t1\t0\t0\t0\t0\n0\t1\t1\t1\t1\t1\t1\t1\t1\t1\t0\t1\t1\t1\t0\t0\t1\t1\t1\t0\t1\t1\t1\t0\t1\t1\t1\t1\t0\t0\t1\t0\t0\t0\t1\t1\t1\t1\t0\t0\t1\t0\t1\t0\t0\t1\t1\t0\t0\t1",
            mode="r", theme="cobalt", height="400px"),

            br(),

            p('If you need to create 1-0 data first, use',
            a('Binary (1-0) Data Converter', href='https://langtest4.shinyapps.io/biconv', target="_blank"), '.'),

            br(),

            h3("Basic statistics (Using the raw score)"),
            verbatimTextOutput("textarea.out"),

            br(),

            h3("Histogram of the total score (Using the raw score)"),

            plotOutput("distPlot"),

            br(),

            h3("Boxplot (Using the raw score)"),


            plotOutput("boxPlot"),

            br(),

            h3("Cronbach's coefficient alpha (Using the raw score)"),
            verbatimTextOutput("alpha.result.out"),

            p('Drop if: Cronbach alpha when the item is removed', br(),
            'r dropped: item-total correlation without the item', br(),
            'r: item-total (point-biserial) correlation', br(),
            'IF: item facility or item mean (proportion correct answers)', br(),
            'ID: item discrimination (upper 1/3 - lower 1/3)', br()
            ),

            br(),

            h3("Item estimate"),
            verbatimTextOutput("item.est.out"),

            br(),

            h3("Person estimate (Theta)"),
            verbatimTextOutput("person.est.out"),

            br(),

            h3("Item fit"),
            verbatimTextOutput("item.fit.out"),

            br(),

            h3("Person fit"),
            verbatimTextOutput("person.fit.out"),

            br(),


            p(strong("Plot Options:")),

            checkboxInput("compare", label = "Show comparison of raw scores and theta", FALSE),
            checkboxInput("map", label = "Plot person-item map", FALSE),
            checkboxInput("path", label = "Plot pathway map (Bond & Fox, 2001, 2007)", FALSE),
            checkboxInput("icc", label = "Plot ICC (item characteristic curves)", FALSE),

            br(),

            verbatimTextOutput("compare.out"),

            plotOutput("compPlot", width="70%"),

            br(),

            plotOutput("piMap"),

            br(),

            plotOutput("pathMap"),

            br(),

            plotOutput("ICC"),

            br(),
            br(),

            strong('R session info'),
            verbatimTextOutput("info.out")

            ),





        tabPanel("About",

            strong('Note'),
            p('This web application is developed with',
            a("Shiny.", href="http://www.rstudio.com/shiny/", target="_blank"),
            ''),

            br(),

            strong('List of Packages Used'), br(),
            code('library(shiny)'),br(),
            code('library(shinyAce)'),br(),
            code('library(psych)'),br(),
            code('library(ltm)'),br(),
            code('library(CTT)'),br(),
            code('library(eRm)'),br(),
            code('library(beeswarm)'),br(),

            br(),
            br(),

            strong('Code'),
            p('Source code for this application is based on',
            a('"The handbook of Research in Foreign Language Learning and Teaching" (Takeuchi & Mizumoto, 2012).', href='http://mizumot.com/handbook/', target="_blank"),'I also referred to the code used in', a("MacR.", href="https://sites.google.com/site/casualmacr/", target="_blank")),

            p('The code for this web application is available at',
            a('GitHub.', href='https://github.com/mizumot/rasch', target="_blank")),

            p('If you want to run this code on your computer (in a local R session), run the code below:',br(),

            code('library(shiny)'),br(),
            code('runGitHub("rasch","mizumot")')
            ),

            br(),

            strong('Citation in Publications'),
            p('Mizumoto, A. (2015). Langtest (Version 1.0) [Web application]. Retrieved from http://langtest.jp'),

            br(),

            strong('Article'),
            p('Mizumoto, A., & Plonsky, L. (2015).', a("R as a lingua franca: Advantages of using R for quantitative research in applied linguistics.", href='http://applij.oxfordjournals.org/content/early/2015/06/24/applin.amv025.abstract', target="_blank"), em('Applied Linguistics,'), 'Advance online publication. doi:10.1093/applin/amv025'),

            br(),

            strong('Recommended'),
            p('To learn more about R, I suggest this excellent and free e-book (pdf),',
            a("A Guide to Doing Statistics in Second Language Research Using R,", href="http://cw.routledge.com/textbooks/9780805861853/guide-to-R.asp", target="_blank"),
            'written by Dr. Jenifer Larson-Hall.'),

            p('Also, if you are a cool Mac user and want to use R with GUI,',
            a("MacR", href="https://sites.google.com/site/casualmacr/", target="_blank"),
            'is defenitely the way to go!'),

            br(),

            strong('Author'),
            p(a("Atsushi MIZUMOTO,", href="http://mizumot.com", target="_blank"),' Ph.D.',br(),
            'Associate Professor of Applied Linguistics',br(),
            'Faculty of Foreign Language Studies /',br(),
            'Graduate School of Foreign Language Education and Research,',br(),
            'Kansai University, Osaka, Japan'),

            br(),

            a(img(src="http://i.creativecommons.org/p/mark/1.0/80x15.png"), target="_blank", href="http://creativecommons.org/publicdomain/mark/1.0/"),


            p(br())

            )

))
))