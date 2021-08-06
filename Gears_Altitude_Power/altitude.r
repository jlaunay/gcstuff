{
    init {
        xx<-c();
        yy<-c();
    }

    relevant {
        Data contains "P";
    }

    finalise {
        # fetch data
        xx <- samples(SECS);
        yy <- samples(ALTITUDE);
        annotate(label, "Altitude (m)");
    }

    x { xx; }
    y { yy; }
}
