#!/bin/bash


Inicial=$1
Final=$2

echo año inicial: $Inicial
echo año final: $Final
# Filtrar columnas fecha, aerolinea, nro. de vuelo 

auxfile="aux_aereolinea.csv"
outfile="../results/aerolinea/aerolinea$1-$2.csv"
data="data-aerolineas.csv"

mkdir "../results/aerolinea"
#Imprimo los campos de datos en el outfile
echo "año, mes,  aerolinea, vuelos_totales, atrasos_totales_arribo, tiempo_atrasado_promedio_arribo, atrasos_totales_salida, tiempo_atrasado_promedio_salida, CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay  " > $outfile

echo > $outfile
echo > $data

#Imprimo los campos de datos en el outfile
echo "aerolinea,vuelos_totales,atrasos_totales_arribo,tiempo_atrasado_porcentaje_arribo,atrasos_totales_salida,tiempo_atrasado_porcentaje_salida,vuelos_cancelados,vuelos_cancelados_porcentaje,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay  " > $outfile



#Para los años en el rango
for ((i=Inicial;i<=Final;i++))
do

	#Cortamos los datos que nos interesan
	cut -f9,15,16,22,25,26,27,28,29  -d, "../data/$i.csv" > $auxfile
	echo "cut1 finished"

	#combinamos auxfile con data sin incluir la primera fila
	tail -n +2 $auxfile >> $data


done

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
			if($8!="NA"){SecurityDelay[$1] +=$8 }; 
			if($9!="NA"){LateAircraftDelay[$1] +=$9 } 

		}; 

		END{ 
			for (id in vuelos_totales) { 
				if(id!="" && id!="Month/Year"){
					print id,
					vuelos_totales[id]+0,
					atrasos_arribo[id]+0,
					atrasos_arribo[id]/vuelos_totales[id]+0,
					atrasos_salida[id]+0,
					atrasos_salida[id]/vuelos_totales[id],
					vuelos_cancelados[id]+0,
					vuelos_cancelados[id]/vuelos_totales[id]+0,
					CarrierDelay[id]+0,
					WeatherDelay[id]+0,
					NASDelay[id]+0,
					SecurityDelay[id]+0,
					LateAircraftDelay[id]+0
				}	
			} 
		}
' 
awk -F',' -vOFS=',' "$awkcommand" < $data >> $outfile



	#Date,arrDelay15,DepDelay16,Cancellation--22, 23 cancelation code ,25CarrierDelay,WeatherDelay26,NASDelay27,SecurityDelay28,LateAircraftDelay29


rm $auxfile
rm $data




