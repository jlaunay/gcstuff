{
    init {
        xx<-c();
        yy<-c();
    }

    relevant {
        Data contains "P";
    }

    finalise {
       annotate(label, "Power (Watts)");

       xx <- samples(SECS);
       yy <- smooth(samples(POWER), sma, centered, 15);
    }

    x { xx; }
    y { yy; }
}
