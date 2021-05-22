#!/bin/bash
# Filtrar columnas fecha, aerolinea, nro. de vuelo 
infile="../results/otps_anuales_1998_2008.csv"
outfile="../results/otps_anuales_1998_2008.csv"

# -f indica que columnas, "-d," significa "delimitador es una ','".
cut -f2,3  -d, $infile > $outfile
