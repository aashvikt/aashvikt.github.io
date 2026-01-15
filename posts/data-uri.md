---
2025-11-11
data uris are pretty cool
a little bit about data uris
sw web
sw draft
---
# data uri

they're

sick


i've been using them

a ton


```
data:text/html,<textarea autofocus style='width:100%;height:100%;border:none;outline:none'/>
```


```
data:text/html,%3Chtml%3E%3Chead%3E%3Ctitle%3ECountdown Timer%3C%2Ftitle%3E%3Cstyle%3Ebody%7Bmargin%3A0%3Bdisplay%3Aflex%3Bjustify-content%3Acenter%3Balign-items%3Acenter%3Bheight%3A100vh%3Bfont-size%3A10vw%3B%7D%3C%2Fstyle%3E%3C%2Fhead%3E%3Cbody%3E%3Cscript%3Elet%20s%3D60%2A60%3B%0Afunction%20updateTime()%7B%0A%20%20%20let%20minutes%3DMath.floor(s%2F60)%2C%0A%20%20%20%20%20%20seconds%3Ds%25%2060%2C%0A%20%20%20%20%20%20timeString%3D%60%24%7Bminutes%7D%3A%24%7Bseconds%3C10%3F'0'%3A''%7D%24%7Bseconds%7D%60%3B%0A%20%20%20document.body.innerHTML%3DtimeString%3B%0A%20%20%20document.title%3DtimeString%3B%0A%20%20%20if%20(s--%3C0)%20s%3D0%3B%0A%20%20%20%7D%0A%0A%20%20%20%2F%2F%20Update%20every%20second%20(1000%20ms)%0A%20%20%20setInterval(updateTime%2C%201000)%3B%0A%3C%2Fscript%3E%3C%2Fbody%3E%3C%2Fhtml%3E
```
