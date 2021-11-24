10 print chr$(147)
11 uprt1=64784
12 scradr1=3072
13 ch=81:delch1=46
20 pv=1:d=1:i=0
30 do
40 poke uprt1,pv
50 poke scradr1+i,ch
70 for j=0to50:next j
80 poke scradr1+i,delch1
85 if i=0 then d=1
86 if i=7 then d=0
87 if d=1 then i=i+1: pv=pv*2
88 if d=0 then i=i-1: pv=pv/2
90 loop while 1=1
100 goto 20
110 end
