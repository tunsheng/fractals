set terminal gif enhanced  animate delay 10
set output 'julia.gif'

#stats 'output.dat' nooutput
set xrange[-2.0:1.5]
set yrange[-1.0:1.0]
set zrange[0:256]

set view map
set palette rgb 30,31,32;
#set palette model HSV defined (0 0 1 1, 1 1 1 1)
unset colorbox
unset xtics
unset ytics

do for [i=1:100] {
 splot 'output.dat' every :::i::i u 1:2:3 w image
}
