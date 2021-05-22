#!/bin/bash
# Filtrar columnas fecha, aerolinea, nro. de vuelo 
infile="info_general.csv"
outfile="info_general2.csv"

#borro info anterior
echo > file.csv

#Dividir por mes, ciclo, guardar variables en un archivo

#cantidad de vuelos
wc -l info_general.csv >> file.csv
#Contar cantidad de atrasos 
awk -F "," '{if($2 > 15)(count++)} END{print count}'  info_general.csv >> file.csv
#Tiempo atraso total
awk -F "," '{if($2 > 15)(count+=$2)} END{print count}'  info_general.csv >> file.csv
#Cantidad de vuelos Cancelados
awk -F "," '{if($4 != 0)(count++)} END{print count}'  info_general.csv >> file.csv
#Cantidad de vuelos por razon
#Codigo similar al anterior
