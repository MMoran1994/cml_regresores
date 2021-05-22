#!/bin/bash
# Filtrar por par origen - destino usando awk.

# Definimos algunas variables. Ojo que a bash no le gustan los espacios cerca del "=".
infile="../results/otps_diarios_1998_2008.csv"
outfile="otps_diarios_2001.csv"

orig_ap="IND" 
dest_ap="PHX"

septiembre=9
octubre=10
noviembre=11
diciembre=12

# Columna 17 aeropuerto origen, columna 18 aeropuerto destino
# Ojo con la secuencia de " y ' al filtrar por &&. 

awk -F, '$0 == "'"2001"'" || $0 == "'"2001"'" || $0 == "'"2001"'" || $0 == "'"2001"'"' $infile > $outfile


#awk -F, '$17 == "'"$orig_ap"'" && $18 == "'"$dest_ap"'"' $infile > $outfile 
