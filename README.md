# Examen iOS
Este repositorio contiene el código fuente del examen de iOS.

## Datos del Alumno
- Nombre completo: Mauricio Olguín Sánchez

- Matrícula: A01711522

- Plataforma: iOS

## Requerimientos Funcionales
1. Listado de países
* Obtener países desde REST Countries (https://restcountries.com/v3.1/all?fields=nameLinks to an external site.).
* Deberás cargar la lista de países y, al darle clic a uno, deberá enviar al detalle del mismo cargando la información adicional.
2. Detalle del país o panel de conversión
* Obtener el detalle del país (https://restcountries.com/v3.1/name/mexicoLinks to an external site.).
* Cargar la información disponible. En caso de que varios países no cuenten con los mismos campos, solo se deberá mostrar la información disponible.
3. Manejo de estados
* Mostrar estados cargando / éxito / error.
* Los errores deben ser entendibles y ofrecer reintento cuando aplique.
4. Persistencia ligera y búsqueda
* Guardar preferencias del usuario: cuando entre a un país se deberá guardar ese país para que, al reabrir la app, la lista lleve al país guardado.
* Implementa búsqueda simple para filtrar elementos de la lista y acceder a un país de manera más rápida.

5. Self-explained hook
* Agrega un botón simple que muestre un diálogo con un texto tomado de una constante de código.
    * El texto del diálogo debe contener 3 piezas (en tus propias palabras): 
        * Arquitectura elegida (MVVM + Clean) y 1 interfaz de dominio real de tu repo (ej.: CountriesRepository).
        * Estrategia de guardado de preferencias
        * Estrategia de búsqueda

## Requerimientos No Funcionales
* Arquitectura:
    * Implementa MVVM.
    * Aplica Clean Architecture separando data / domain / presentation.
* UI moderna:
    * Android: Jetpack Compose / iOS: SwiftUI.
    * Diseño responsive, accesible y claro.
* Estados y rendimiento:
    * No bloquees UI; usa corrutinas/async correctamente.

* DI:
    * Se valora el uso de Hilt (Android) o inyección simple / Protocols (iOS) para dependencias (clients, repositorios).

* Repositorio GitHub público e individual, con README.md que incluya:

    * **Nombre completo**

    * **Matrícula/ID**

    * **Plataforma (Android/iOS)**

    * **(Obligatorio)** En caso de omitir README completo: -5 pts.

## Alineación del desarrollo de software con la metodología ágil

El siguiente texto tiene como objetivo describir cómo es que las etapas del desarrollo de software se alinean con la metodología ágil. Esto para los puntos 5 puntos extras.

### La arquitectura MVVM + Clean Architecture

Cuando se escoge trabajar con este tipo de arquitectura (MVVM + Clean Architecture), principalmente, se busca crear un entorno de desarrollo que sea:
* flexible;
* escalable;
* y sobre todo, mantenible.

La estrctura entonces se divide en tres capas principales:
1. Presentación (View y ViewModel)
2. Dominio (Use Cases)
3. Datos (Repositorios y Fuentes de Datos)

### La metodología Ágil

La metodología ágil a la par, surge como solución a proyectos que requieren de una adaptabilidad y flexibilidad constante. Su base está hecha para que los equipos puedan responder rápidamente a los cambios y entregar valor de manera continua.

Las principales partes de la metodología ágil son:
* *Sprints*: ciclos cortos de desarrollo que perminten entregar incrementos funcionales del producto.
* Reuniones diarias (*Dailys*): reuniones cortas para sincronizar al equipo
* Retrospectivas: reuniones para reflexionar sobre el proceso y buscar mejoras continuas.
* *Product backlog*: lista priorizada de funcionalidades y tareas que deben ser abordadas.
* Historias de usuario: descripciones breves de funcionalidades desde la perspectiva del usuario final.
* *Sprint Review*: revisión del trabajo realizado al final de cada *sprint* para obtener retroalimentación.

### Entonces, ¿de que nos sirve usar ambos? / Conclusiones

Al combinar MVVM + Clean Architecture con la metodología ágil, nos permite poder tener un desarrollo de software que es este sea:
1. Adaptable
2. Colaborativo
3. Enfocado en el usuario
4. De alta calidad

Al final, esta singeria nos permite crear software que no sólo le cumpla al usuario final o al cliente un producto, sino que un producto que sea de calidad, que pueda evolucionar con el tiempo y que se adapte a las necesidades que puedan surgir con el tiempo.

## Reflexión final personal sobre este examen

Quice incluir esta última sección al final del repo (aunque no sea necesario) porque, mientras realizaba este mismo examen, recordaba mucho las palabras del profesor Alex en la última clase que tuvimos. En esta clase, nos dijo algo cómo:

> Chicos, aunque puedan hablar con sus compañeros, no lo hagan porque
> 1. Eso les probocaría una FIA (o algo por el estilo) y;
> 2. Para medir sus capacidades como desarrolladores de software.

Y lo importante de esto fue lo último, ***para medir mis capacidades como desarrollador***.

Entonces, mientras realizaba este examen, me di cuenta de que no soy una persona muy ágil (ja ja ja), en el sentido de que, me cuesta algo de trabajo poder decir de forma rápida para poder empezar trabajos, o tal vez, analízo más tiempo del que debería cuando estoy bajo presión. Esto lo digo porque noté como, en las primeras dos horas del examen, casi no había escrito nada de código, simplemente me estaba organizando tanto en la estructura del proyecto, así como informandome sobre cómo funcionaba las API y las caracterísitcas finales que tuviera la aplicación.

Es por esta razón por la cuál entrego tarde este examen, pero a decir verdad, creo que con este examen aprendí mucho sobre cómo soy como desarrollador y en qué tipo de ambientes me gustarían estar pues, si bien es inevitable que la vida me conduzca a situaciones bajo presión, creo que en un futuro, me gustaría trabajar en algo en dónde esto no sea una constante, pues es bastante desgastante.