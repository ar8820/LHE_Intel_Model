pathPrep <- function(path = "clipboard") {
    y <- if (path == "clipboard") {
        readClipboard()
    } else {
        cat("Please enter the path:\n\n")
        readline()
    }
    x <- chartr("\\", "/", y)
    writeClipboard(x)
    return(x)
}