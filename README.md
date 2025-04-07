AyusoConMorty es una aplicación de iOS desarrollada en SwiftUI que muestra una grid con los personajes del universo de Rick and Morty.

    Lista Grid:
    Muestra los personajes en una vista de grid eficiente reusando celdas

    Búsqueda de personajes:
    Utiliza un TextFieldSearch para buscar personajes, la búsqueda es por nombre de personaje exacto no por coincidencias, se activa al pulsar "enter" y se filtran los resultados.

    Detalles en del personaje:
    Al tocar sobre una cardImage (personaje) se abre una sheet que muestra más información sobre el mismo.

    Caché en memoria:
    Se implementa una cache para almacenar los personajes y evitar cargas innecesarias. La caché se invalida si la app se pone en segundo plano durante 7 minutos.

    Pruebas Unitarias y UI Tests:
    Incluye pruebas unitarias para la func de lógica y tests de interfaz para verificar la experiencia del usuario.

Tecnologías

    SwiftUI:
    La interfaz de usuario se construye con SwiftUI

    UIKit:
    Gestiona la cache de imagenes

    Testing:
    Se incluyen tests unitarios y UI tests usando la API de Testing de Xcode.

Instalación

    Clonar el repositorio:

    git clone https://github.com/your_user/AyusoConMorty.git 
    cd AyusoConMorty

    Abrir el proyecto en Xcode:

    Abre el archivo AyusoConMorty.xcodeproj

    Compilar y ejecutar:
    Selecciona tu dispositivo físico o simulador y compila la aplicación.

Uso

    Al iniciar la app, se mostrará una grid con los personajes.

    Escribe en el TextFieldSearch para buscar personajes por nombre.
    Al pulsar "enter", se activará la búsqueda y se actualizarán los resultados.

    Pulsa sobre una CardImage de personaje para ver los detalles en una sheet.
