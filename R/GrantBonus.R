GrantBonus <-
bonus <-
paybonus <-
function (workers, assignments, amounts, reasons, keypair = credentials(), 
    print = getOption('MTurkR.print'), browser = getOption('MTurkR.browser'),
    log.requests = getOption('MTurkR.log'), sandbox = getOption('MTurkR.sandbox'),
	validation.test = getOption('MTurkR.test')) {
    if(!is.null(keypair)) {
        keyid <- keypair[1]
        secret <- keypair[2]
    }
    else
        stop("No keypair provided or 'credentials' object not stored")
    operation <- "GrantBonus"
    if(!length(workers) == length(assignments)) 
        stop("Number of workers does not match number of assignments")
    if(length(amounts) == 1) 
        amounts <- rep(amounts[1], length(workers))
    if(!length(amounts) == length(workers)) 
        stop("Number of amounts is not 1 nor length(workers)")
    if(length(reasons) == 1) 
        reasons <- rep(reasons[1], length(workers))
    if(!length(reasons) == length(workers)) 
        stop("Number of reasons is not 1 nor length(workers)")
    if(is.factor(workers))
        workers <- as.character(workers)
    if(is.factor(assignments))
        assignments <- as.character(assignments)
    if(is.factor(reasons))
        reasons <- as.character(reasons)
    if(is.factor(amounts))
        amounts <- as.character(amounts)
    for(i in 1:length(amounts)) {
        if(!is.numeric(as.numeric(amounts))) 
            stop(paste("Non-numeric bonus amount requested for bonus ", i, sep = ""))
    }
    Bonuses <- setNames(data.frame(matrix(nrow = length(workers), ncol = 5)),
                    c("WorkerId", "AssignmentId", "Amount", "Reason", "Valid"))
    for(i in 1:length(workers)) {
        GETparameters <- paste("&WorkerId=", workers[i], "&AssignmentId=", 
            assignments[i], "&BonusAmount.1.Amount=", amounts[i], 
            "&BonusAmount.1.CurrencyCode=USD", "&Reason=", curlEscape(reasons[i]), 
            sep = "")
        auth <- authenticate(operation, secret)
        if(browser == TRUE) {
            request <- request(keyid, auth$operation, auth$signature, 
                auth$timestamp, GETparameters, browser = browser, 
                sandbox = sandbox, validation.test = validation.test)
			if(validation.test)
				return(invisible(request))
        }
        else {
            request <- request(keyid, auth$operation, auth$signature, 
                auth$timestamp, GETparameters, log.requests = log.requests, 
                sandbox = sandbox, validation.test = validation.test)
			if(validation.test)
				return(invisible(request))
            Bonuses[i, ] <- c(workers[i], assignments[i], amounts[i], 
                reasons[i], request$valid)
            if(request$valid == TRUE) {
                if(print == TRUE) 
                    message(i, ": Bonus of ", amounts[i], " granted to ", 
                    workers[i], " for assignment ", assignments[i])
            }
            else if(request$valid == FALSE) {
                if(print == TRUE) 
                    warning("Invalid Request for worker ", workers[i])
            }
        }
    }
    Bonuses$Valid <- factor(Bonuses$Valid, levels=c('TRUE','FALSE'))
    return(Bonuses)
}
