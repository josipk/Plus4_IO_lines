10 print chr$(147)
20 pv=1:ch=81:delch1=32
25 uprt1=64784
26 scradr1=3072
30 for i=0to7
40 poke uprt1,pv
50 poke scradr1+i,ch
60 pv=pv*2
70 for j=0to100:next j
80 poke scradr1+i,delch1
90 next i
100 goto 20
110 end
