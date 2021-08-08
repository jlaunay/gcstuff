##
## Plot wind speed and direction from XDATA WEATHER
##
import plotly.graph_objects as go
import tempfile
import pathlib
import numpy as np
import time

if 'WEATHER' in GC.xdataNames():

    # Define temporary file
    temp_file = tempfile.NamedTemporaryFile(mode="w+t",
                                            prefix="GC_",
                                            suffix=".html",
                                            delete=False)

    xx = np.asarray(GC.xdataSeries("WEATHER", "secs"))

    wd = np.asarray(GC.xdataSeries('WEATHER', 'WINDDIRECTION')).astype(float)
    ws = np.asarray(GC.xdataSeries('WEATHER', 'WINDSPEED')).astype(float)

    fig = go.Figure()

    for x, y, t in zip(wd, ws, xx):
        print(y, x)
        fig.add_trace(
            go.Barpolar(
                r=[y],
                theta=[x],
                name='Wind speed: ' + str(y) + " km/h at " +
                time.strftime('%H:%M', time.gmtime(t)),
            ))

    fig.update_layout(
        template="plotly_dark",
        polar=dict(angularaxis=dict(
            tickfont_size=18,
            rotation=90,  # start position of angular axis
            direction="clockwise",
            showticklabels=True,
            ticks=''))  #,
        #legend=dict(
        #    yanchor="top",
        #    y=0,
        #    xanchor="left",
        #    x=0
        #)
    )

    ## Prepare Plot
    with open(temp_file.name, 'a') as f:
        f.write(fig.to_html(full_html=False, include_plotlyjs='cdn'))

    f.close()

else:
    f = open(temp_file.name, "w+")
    lines_of_text = [
        "<html>", "<body>",
        "<p> Unable to draw plot <br> No WEATHER Data found</p>", "</body>",
        "</html>"
    ]
    f.writelines(lines_of_text)
    f.close()

## Load Plot
GC.webpage(pathlib.Path(temp_file.name).as_uri())
