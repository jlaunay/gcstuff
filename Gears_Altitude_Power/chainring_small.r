{
    init {
        xx<-c();
        yy<-c();
        rear<-c();
        front<-c();
        gears<-c();
    }

    relevant {
        
        if(XDATA ("GEARS", "FRONT", sparse) = 0){
          annotate(label,"Error ! No Gears data in this activity.");
        }
        XDATA ("GEARS", "FRONT", sparse);
        
    }

    finalise {
	    # fetch power and time
		secs <- xdata("GEARS",secs);
		front <- xdata("GEARS","FRONT");
		rear <- xdata("GEARS","REAR");

		# remove abnormal values (ex: 255 or 0)
		secs <- sapply(secs,front[i]=255 || front[i]<=0 ? 99999 : x )[x<>99999];
		front <- sapply(front,front[i]=255 || front[i]<=0 ? 99999 : x )[x<>99999];
		rear <- sapply(rear,front[i]=255 || front[i]<=0 ? 99999 : x )[x<>99999];
	
		# nothing if only max
		if(min(front) = max(front)){
			rear <- c();
		}
		if(min(front) <> max(front)){
			annotate(label, "Chainring (small):",min(front),"teeth");
		}
	
		# keep only rear when front is min
		rear <- sapply(rear,front[i]=min(front) ? x : 99999 )[x<>99999];
		secs <- sapply(secs,front[i]=min(front) ? x : 99999 )[x<>99999];
    }

    x { secs; }
    y { rear; }
}
