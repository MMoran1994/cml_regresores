# Trabajo práctico: Cuadrados Mínimos Lineales
El archivo `enunciado.pdf` contiene todo lo que fue requerido para la realización del trabajo. 
- La carpeta `src` contiene el código C++ utilizado además de la vinculación con el módulo `pybind`. 
- En `notebooks` se encuentran las notebooks de Jupyter usadas para procesar los datos y realizar los experimentos.
- En `results` se encuentran guardados los datos ya procesados para realizar su estudio.
- En `filtros` y `tools` los comandos del Shell de Linux utilizados para filtrar los archivos .csv de manera casi instantánea.
- El módulo `eigen` contiene lo necesario para la representación y operaciones de matrices.
- Se incluyen además el informe en `informe.pdf` pedido por el enunciado en el que se exhiben los hallazgos más relevantes dados por la experimentación y `Presentacion.pdf` con las diapositivas utilizados por el grupo para dar la exposición presencial del trabajo.

Por comodidad del lector, a continuación se deja una copia de las secciones de Enunciado y Experimentación la cual resumen en gran parte los objetivos del trabajo práctico. Para leer sobre la problemática en la que fueron utilizadas las técnicas leer el mencionado ya `enunciado.pdf`:


# Enunciado

```
El Trabajo Práctico tiene como punto de partida considerar los datos provistos por
http://stat-computing.org/dataexpo/2009/ y formular distintos ejes de análisis relacionados con la temática propuesta. Para ello,
se deberá utilizar CML como técnica de análisis y modelado, tanto a nivel descriptivo
de los datos como a nivel predictivo de eventos futuros. Para la experimentación se podrá
considerar como posible lenguaje Python, pero la implementación de CML debe ser en
C++. Para la misma pueden utilizar SVD, QR o ecuaciones normales. No es necesario
realizar toda la implementación desde cero y es posible utilizar rutinas provistas por
dichos lenguajes mientras las mismas no resuelvan CML.
El objetivo principal de este trabajo se centra en la aplicación de las técnicas
regresión lineal a una temática práctica concreta y en la correspondiente experimentación
necesaria para evaluar los desarrollos. Otro objetivo del trabajo práctico es que cada
grupo pueda aplicar parte del conocimiento metodológico adquirido durante los primeros
dos trabajos prácticos y las clases de laboratorio.

```

# Experimentación

```
A diferencia de trabajos prácticos anteriores, la experimentación a realizar no está
completamente definida en el presente enunciado. Para realizar las misma se deben
seguir los ejes de estudio planteados a continuación y dentro de cada uno proponer un
desarrollo con experimentos que sirvan para responder las preguntas planteadas. No es
obligatorio responder a todas la preguntas y cada grupo puede plantear nuevas siempre
y cuando se mantenga el objetivo de cada uno de los eje de estudio.

```
## Primer eje de estudio

```
El primer eje de estudio estará basado en evaluar el OTP como indicador de performance y tiene como objetivo poder saber en qué o cuáles situaciones se puede confiar en
utilizarlo como métrica de evaluación para predecir futuros problemas de puntualidad.
A continuación se plantean preguntas para proponer experimentaciones:

¿El indicador OTP resulta eficiente para evaluar la calidad de las aerolíneas? ¿Se
puede aplicar este indicador para evaluar los aeropuertos? ¿Y entre pares de ciu-
dades en particular?

¿Es posible caracterizar la magnitud de los delays en función del día/mes? ¿Se
puede predecir si mañana o el mes siguiente habrá muchos retrasos?

¿Qué nivel de granularidad en función del tiempo es conveniente tomar?

Las condiciones y requerimientos mínimos de seguridad produjeron cambios significativos luego del 9/11 en los Estados Unidos. ¿Cómo afecta esto a los modelos
predictivos?
```

## Segundo eje de estudio

```
El segundo eje de estudio tiene como objetivo analizar los factores que impactan
en las estimaciones y predicciones del OTP. Las preguntas para orientativas son las
siguientes:

¿Cómo varía la cantidad de vuelos cancelados por mes a través de los años? ¿Está
relacionada con la magnitud de los retrasos y el OTP? ¿Se puede predecir el delay
solamente con las cancelaciones?

¿Se pueden utilizar las cancelaciones como un indicador de performance?


¿Qué otras variables afectan el OTP? ¿Es importante diferenciar efectos estacionales como el clima, temporada alta, fechas particulares con picos de demanda,
etc.?

¿El tipo o antiguedad en los aviones es importante? ¿Qué otras características
externas podemos analizar para predecir un impacto en el OTP?
```
