#!/bin/bash


Inicial=$1
Final=$2

echo año inicial: $Inicial
echo año final:$Final
# Filtrar columnas fecha, aerolinea, nro. de vuelo 

auxfile="aux.csv"
aux2file="info_general.csv"
outfile="../results/info$1-$2.csv"

#Imprimo los campos de datos en el outfile
echo "anio, mes, vuelos_totales, atrasos_totales_arribo, tiempo_atrasado_promedio_arribo, atrasos_totales_salida, tiempo_atrasado_promedio_salida, vuelos_cancelados,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay  " > $outfile

#Para los años en el rango
for ((i=Inicial;i<=Final;i++))
do

	#Cortamos los datos que nos interesan
	cut -f1,2,15,16,22,23,25,26,27,28,29  -d, "../data/$i.csv" > $auxfile

	#Para cada mes del año
	for ((j=1;j<=12;j++))
	do
		echo "año: "$i " mes: "$j
		text="${i}, ${j}"
		#filtro por mes y agrego los elementos en el archivo auxiliar
		grep $i,$j, < $auxfile > $aux2file
		#cantidad de vuelos
		text="${text}, $(wc -l < $aux2file)"
		#Contar cantidad de atrasos arribo
		aux=$(awk -F "," '{if($3 > 15)(count++)} END{print count}' $aux2file)
		text="${text}, ${aux}"
		#Tiempo atraso promedio arribo
		aux2=$(awk -F "," '{if($3 > 15)(count+=$3)} END{print count}' $aux2file)
		text="${text}, $(echo "scale=5 ; $aux2 / $aux" | bc)"
		
		#Contar cantidad de atrasos salida
		aux=$(awk -F "," '{if($4 > 15)(count++)} END{print count}' $aux2file)
		text="${text}, ${aux}"
		#Tiempo atraso promedio salida
		aux2=$(awk -F "," '{if($4 > 15)(count+=$4)} END{print count}' $aux2file)
		text="${text}, $(echo "scale=5 ; $aux2 / $aux" | bc)"
		#Cantidad de vuelos Cancelados
		text="${text}, $(awk -F "," '{if($5 != 0)(count++)} END{print count}'  $aux2file)"
		#Cantidad de vuelos demorados por razon
		#CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay
		text="${text}, $(awk -F "," 'BEGIN{count=0}{if($7!="NA")(count+=$7)} END{print count}' $aux2file)"
		text="${text}, $(awk -F "," 'BEGIN{count=0}{if($8!="NA")(count+=$8)} END{print count}' $aux2file)"
		text="${text}, $(awk -F "," 'BEGIN{count=0}{if($9!="NA")(count+=$9)} END{print count}' $aux2file)"
		text="${text}, $(awk -F "," 'BEGIN{count=0}{if($10!="NA")(count+=$10)} END{print count}' $aux2file)"
		text="${text}, $(awk -F "," 'BEGIN{count=0}{if($11!="NA")(count+=$11)} END{print count}' $aux2file)"




		echo $text
		#Imprimo ese mes y año en el archivo de salida
		echo $text >> $outfile

	done

done

rm $auxfile
rm $aux2file


