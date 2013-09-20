DisposeQualificationType <-
disposequal <-
function (qual, keypair = credentials(), print = TRUE, browser = FALSE, 
    log.requests = TRUE, sandbox = FALSE, validation.test = FALSE) 
{
    if (!is.null(keypair)) {
        keyid <- keypair[1]
        secret <- keypair[2]
    }
    else stop("No keypair provided or 'credentials' object not stored")
    operation <- "DisposeQualificationType"
    if (is.null(qual)) 
        stop("Must specify QualificationTypeId")
    else GETparameters <- paste("&QualificationTypeId=", qual, 
        sep = "")
    auth <- authenticate(operation, secret)
    if (browser == TRUE) {
        request <- request(keyid, auth$operation, auth$signature, 
            auth$timestamp, GETparameters, browser = browser, 
            sandbox = sandbox, validation.test = validation.test)
		if(validation.test)
			invisible(request)
    }
    else {
        QualificationTypes <- data.frame(matrix(ncol = 2))
        names(QualificationTypes) <- c("QualificationTypeId", "Valid")
        request <- request(keyid, auth$operation, auth$signature, 
            auth$timestamp, GETparameters, log.requests = log.requests, 
            sandbox = sandbox, validation.test = validation.test)
		if(validation.test)
			invisible(request)
        if (request$valid == TRUE) {
            QualificationTypes[1, ] <- c(qual, request$valid)
            if (print == TRUE) {
                message("QualificationType ", qual, " Disposed")
                return(QualificationTypes)
            }
            else
				invisible(QualificationTypes)
        }
        else if (request$valid == FALSE) {
            if (print == TRUE) 
                warning("Invalid Request\n")
            invisible(NULL)
        }
    }
}