#!/bin/bash


Inicial=$1
Final=$2

echo año inicial: $Inicial
echo año final:$Final
# Filtrar columnas fecha, aerolinea, nro. de vuelo 

auxfile="aux_dia.csv"
aux2file="info_general_dia.csv"
outfile="../results/dia/info_dia$1-$2.csv"


mkdir "../results/dia"
echo > $outfile

#Imprimo los campos de datos en el outfile
echo "fecha,vuelos_totales,atrasos_totales_arribo,atrasos_totales_salida,vuelos_cancelados,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay  " > $outfile

#Para los años en el rango
for ((i=Inicial;i<=Final;i++))
do

	#Cortamos los datos que nos interesan
	cut -f1,2,3,15,16,22,25,26,27,28,29  -d, "../data/$i.csv" > $auxfile
	echo "cut1 finished"
	#Utilizamos dia mes año como fecha
	awk -F',' -vOFS=',' '{$(1)=$3"/"$2"/"$1 ; if (NR!=0) print}' < $auxfile > $aux2file
	cut -f1,4,5,6,7,8,9,10,11 -d, $aux2file > $auxfile
	#echo "cut2 finished"
	#auxfile contiene la info


	awkcommand='
		BEGIN{	vuelos_totales[$1]=0; 
				atrasos_arribo[$1]=0; 
				atrasos_salida[$1]=0; 
				vuelos_cancelados[$1]=0; 
				CarrierDelay[$1]=0; 
				WeatherDelay[$1]=0; 
				NASDelay[$1]=0; 
				SecurityDelay[$1]=0; 
				LateAircraftDelay[$1]=0 
			};

			{
				vuelos_totales[$1] += 1 ;
				if($2>15) {atrasos_arribo[$1] += 1};
				if($3>15) {atrasos_salida[$1] += 1};
				if($4!=0){vuelos_cancelados[$1] += 1}; 
				if($5!="NA") {CarrierDelay[$1] += $5}; 
				if($6!="NA"){WeatherDelay[$1] += $6} ; 
				if($7!="NA"){NASDelay[$1] += $7}; 
				if($8!="NA"){SecurityDelay[$1] +=$8}; 
				if($9!="NA"){LateAircraftDelay[$1] +=$9 } 

			}; 

			END{ 
				for (id in vuelos_totales) { 
					if(id!="" && id!="DayofMonth/Month/Year"){
						print id,
						vuelos_totales[id],
						atrasos_arribo[id],
						atrasos_salida[id],
						vuelos_cancelados[id],
						CarrierDelay[id]+0,
						WeatherDelay[id]+0,
						NASDelay[id]+0,
						SecurityDelay[id]+0,
						LateAircraftDelay[id]+0
					}	
				} 
			}
	' 

	awk -F',' -vOFS=',' "$awkcommand" < $auxfile >> $outfile


	#Date,arrDelay15,DepDelay16,Cancellation--22, 23 cancelation code ,25CarrierDelay,WeatherDelay26,NASDelay27,SecurityDelay28,LateAircraftDelay29

done

rm $auxfile
rm $aux2file

