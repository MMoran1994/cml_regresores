#!/bin/bash


Inicial=$1
Final=$2

echo año inicial: $Inicial
echo año final: $Final
# Filtrar columnas fecha, aerolinea, nro. de vuelo 

auxfile="aux_aeropuerto.csv"
aux2file="info_general_aeropuerto.csv"
outfile="../results/aeropuerto/aeropuertos$1-$2.csv"
aereopuertos="../results/airports.csv"
data1="data1-aeropuerto.csv"
data2="data2-aeropuerto.csv"

mkdir "../results/aeropuerto"

#Imprimo los campos de datos en el outfile
echo "aeropuerto,vuelos_totales,atrasos_totales,vuelos_cancelados,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay  " > $outfile


echo > $data1
echo > $data2

#Filtro usando puerto como salida
for ((i=Inicial;i<=Final;i++))
do

	#Cortamos los datos que nos interesan
	cut -f17,15,16,22,25,26,27,28,29  -d, "../data/$i.csv" > $auxfile
	echo "cut1 finished"

	awk -F',' -vOFS=',' '{$(1)=$3 ; {print}}' < $auxfile > $aux2file
	cut -f1,2,4,5,6,7,8,9 -d, $aux2file > $auxfile
	#combinamos auxfile con data sin incluir la primera fila
	tail -n +2 $auxfile >> $data1


done

#Filtro usando puerto como entrada
for ((i=Inicial;i<=Final;i++))
do

	#Cortamos los datos que nos interesan
	cut -f15,16,18,22,25,26,27,28,29  -d, "../data/$i.csv" > $auxfile
	echo "cut1 finished"

	awk -F',' -vOFS=',' '{$(1)=$3 ; {print}}' < $auxfile > $aux2file
	cut -f1,2,4,5,6,7,8,9 -d, $aux2file > $auxfile
	#combinamos auxfile con data sin incluir la primera fila
	tail -n +2 $auxfile >> $data2


done

#Suma y promedio por id (primera fila de la data)
awkOrigen='
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
				if(id!="" && id!="Month/Year"){
					print id,
					vuelos_totales[id]+0,
					atrasos_salida[id]+0,
					vuelos_cancelados[id]+0,
					CarrierDelay[id]+0,
					WeatherDelay[id]+0,
					NASDelay[id]+0,
					SecurityDelay[id]+0,
					LateAircraftDelay[id]+0
				}	
			} 
		}
' 

awkDestino='
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
			if($4!=0){vuelos_cancelados[$1] += 1}; 
			if($5!="NA") {CarrierDelay[$1] += $5}; 
			if($6!="NA"){WeatherDelay[$1] += $6} ; 
			if($7!="NA"){NASDelay[$1] += $7}; 
			if($8!="NA"){SecurityDelay[$1] +=$8}; 
			if($9!="NA"){LateAircraftDelay[$1] +=$9 } 

		}; 

		END{ 
			for (id in vuelos_totales) { 
				if(id!="" && id!="Month/Year"){
					print id,
					vuelos_totales[id]+0,
					atrasos_arribo[id]+0,
					vuelos_cancelados[id]+0,
					CarrierDelay[id]+0,
					WeatherDelay[id]+0,
					NASDelay[id]+0,
					SecurityDelay[id]+0,
					LateAircraftDelay[id]+0
				}	
			} 
		}
' 

#origen
awk -F',' -vOFS=',' "$awkOrigen" < $data1 > $auxfile
#destino
awk -F',' -vOFS=',' "$awkDestino" < $data2 >> $auxfile

awkcommand='
	BEGIN{	
		vuelos_totales[$1]=0; 
		atrasos_totales[$1]=0; 
		vuelos_cancelados[$1]=0; 
		CarrierDelay[$1]=0; 
		WeatherDelay[$1]=0; 
		NASDelay[$1]=0; 
		SecurityDelay[$1]=0; 
		LateAircraftDelay[$1]=0 
	};

	{
		vuelos_totales[$1] += $2 ;
		{atrasos_totales[$1] += $3};
		{vuelos_cancelados[$1] += $4}; 
		{CarrierDelay[$1] += $5}; 
		{WeatherDelay[$1] += $6} ; 
		{NASDelay[$1] += $7}; 
		{SecurityDelay[$1] += $8}; 
		{LateAircraftDelay[$1] +=$9} 

	}; 

	END{ 
			for (id in vuelos_totales) { 
				if(id!="" && id!="Month/Year"){
					print id,
					vuelos_totales[id]+0,
					atrasos_totales[id]+0,
					vuelos_cancelados[id]+0,
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


rm $auxfile
rm $aux2file
rm $data1
rm $data2



