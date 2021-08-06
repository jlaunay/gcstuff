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
	
	    # keep only rear when front is min
        rear <- sapply(rear,front[i]=max(front) ? x : 99999 )[x<>99999];
        secs <- sapply(secs,front[i]=max(front) ? x : 99999 )[x<>99999];
        
        annotate(label, "Chainring (large):",max(front),"teeth");
    }

    x { secs; }
    y { rear; }
}
