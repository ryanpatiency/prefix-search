
set title "prefix search time catagory"
set xlabel "lower bound (sec)"
set ylabel "frequency"
set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 0.9
set xtic rotate by -45 scale 0
set term png enhanced font 'Verdana,10'
set output 'ref_freq.png'
plot 'ref_freq.txt' using 2:xtic(1)