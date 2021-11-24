10 print chr$(147)
20 pv=1:ch=81:delch1=32:uport=64784:saddr=3072
30 for i=0to7
40 poke uport,pv
50 poke saddr+i,ch
60 poke 2048+i,1
70 if int(pv and 2^i) > 0 then poke 2048+i,25
80 next i
90 pv=pv+1
100 for j=0to100:next j
110 goto 30
120 end
