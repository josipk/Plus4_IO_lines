10 print chr$(147)
20 pv=1:ch=81:delch1=32
25 uprt1=64784
26 scradr1=3072
30 for i=0to7
40 poke uprt1,pv
50 pv=pv+pv or 1
60 for j=0to100:next j
70 next i
80 goto 20
90 end
