from flask import Flask, jsonify, request
from proximo_feriado import NextHoliday
import random

app = Flask(__name__)
peliculas = [
    {'id': 1, 'titulo': 'Indiana Jones', 'genero': 'Acción'},
    {'id': 2, 'titulo': 'Star Wars', 'genero': 'Acción'},
    {'id': 3, 'titulo': 'Interstellar', 'genero': 'Ciencia ficción'},
    {'id': 4, 'titulo': 'Jurassic Park', 'genero': 'Aventura'},
    {'id': 5, 'titulo': 'The Avengers', 'genero': 'Acción'},
    {'id': 6, 'titulo': 'Back to the Future', 'genero': 'Ciencia ficción'},
    {'id': 7, 'titulo': 'The Lord of the Rings', 'genero': 'Fantasía'},
    {'id': 8, 'titulo': 'The Dark Knight', 'genero': 'Acción'},
    {'id': 9, 'titulo': 'Inception', 'genero': 'Ciencia ficción'},
    {'id': 10, 'titulo': 'The Shawshank Redemption', 'genero': 'Drama'},
    {'id': 11, 'titulo': 'Pulp Fiction', 'genero': 'Crimen'},
    {'id': 12, 'titulo': 'Fight Club', 'genero': 'Drama'}
]
next_holiday = NextHoliday()


def obtener_peliculas():
    """
    Nos indica todas las peliculas disponibles

    Parameters:
        No recibe

    Returns:
        peliculas(list): Un objeto JSON con la lista de peliculas

    """
    return jsonify(peliculas)


def obtener_pelicula(id_pelicula):
    """
    Busca una pelicula por su ID

    Parameters:
        id_pelicula(int): ID con el que buscar la pelicula

    Returns:
        - Un objeto JSON con los detalles de la pelicula en formato dict
        - Un objeto JSON que contiene un mensaje y el número de tipo de error

    """
    # Lógica para buscar la película por su ID y devolver sus detalles
    pelicula_encontrada = None
    for pelicula in peliculas:
        if pelicula["id"] == id_pelicula:
            pelicula_encontrada = pelicula
    # Si no encontramos la película, devolvemos un error 404
    if pelicula_encontrada is None:
        return jsonify({"error": "Película no encontrada"}), 404

    return jsonify(pelicula_encontrada)


def agregar_pelicula():
    """
    Agrega una nueva pelicula

    Parameters:
        - La funcion no recibe, luego los pide

    Returns:
        - Un Objeto JSON que contiene un dict con los datos de la nueva
          pelicula

    """
    nueva_pelicula = {
        'id': obtener_nuevo_id(),
        'titulo': request.json['titulo'],
        'genero': request.json['genero']
    }
    peliculas.append(nueva_pelicula)
    print(peliculas)
    return jsonify(nueva_pelicula), 201


def actualizar_pelicula(id_pelicula):
    """
    Actualiza los detalles de una película existente en la lista de películas.

    Parameters:
        id_pelicula(int): ID de la pelicula que se desea actualizar

    Returns:
        - Un objeto JSON con los detalles de la pelicula en formato dict
        - Un objeto JSON que contiene un mensaje y el número de tipo de error

    """
    # Lógica para buscar la película por su ID y actualizar sus detalles
    pelicula_actualizada = None
    for pelicula in peliculas:
        if pelicula["id"] == id_pelicula:
            titulo = request.json['titulo']
            genero = request.json['genero']
            if titulo != "":
                pelicula['titulo'] = request.json['titulo']
            if genero != "":
                pelicula['genero'] = request.json['genero']
            pelicula_actualizada = pelicula
            break

    # Si no encontramos la película, devolvemos un error 404
    if pelicula_actualizada is None:
        return jsonify({"error": "Película no encontrada"}), 404
    return jsonify(pelicula_actualizada)


def eliminar_pelicula(id_pelicula):
    """
    Elimina una pelicula por su ID

    Parameters:
        id_pelicula(int): ID con el que buscar y eliminar la pelicula

    Returns:
        - Un objeto JSON con un mensaje de sí se eliminó la pelicula o un error

    """
    # Lógica para buscar la película por su ID y eliminarla

    for pelicula in peliculas:
        if pelicula["id"] == id_pelicula:
            peliculas.remove(pelicula)
            return jsonify({'mensaje': 'Película eliminada correctamente'})
    return jsonify({'error': 'Película no encontrada'}), 404


def filtrar_pelicula(genero):
    """
    Filtra y devuelve una lista de películas que pertenecen a un género
    específico.

    Parameters:
        genero(string): género por el que se desea filtrar la lista de
                        peliculas

    Returns:
        - Un objeto JSON con la lista de películas filtradas por género.
        - Un objeto JSON que contiene un mensaje y el número de tipo de error

    """
    return jsonify(_filtrar_(genero))


def pelicula_con_palabra(palabra):
    """
    Devuelve las peliculas con una palabra en el título

    Parameters:
        palabra(string): palabra que se va a buscar en el título de las
                         peliculas

    Returns:
        - Un objeto JSON con una lista de peliculas con esa palabra en el
          título

    """
    # Lógica para buscar la película por su ID y devolver sus detalles
    palabra_contenida = []
    for pelicula in peliculas:
        if pelicula["titulo"].find(palabra) != -1:
            palabra_contenida.append(pelicula)
    # Si no encontramos la película, devolvemos un error 404
    if not palabra_contenida:
        return jsonify({"error": "Ningun titulo contiene esa palabra"}), 404

    return jsonify(palabra_contenida)


def sugerir_pelicula():
    """
    Devuelve una película aleatoria del listado de peliculas.

    Returns:
        - Un objeto JSON con los detalles de una película elegida
          aleatoriamente.

    """
    filtrados = []
    for pelicula in peliculas:
        filtrados.append(pelicula)
    peli = random.choice(filtrados)
    return jsonify(peli)


def sugerir_pelicula_genero(genero):
    """
    Devuelve una película aleatoria de del genero especificado.

    Parameters:
        genero(string): género por el que se desea filtrar la sugerencia.

    Returns:
        - Un JSON con los detalles de una película elegida aleatoriamente.
        - Un JSON con un mensaje de error si no hay películas en el género
          especificado.

    """
    peliculas_filtradas = _filtrar_(genero)
    if not peliculas_filtradas:
        return jsonify({"error": "No hay peliculas con ese genero"}), 404
    peli = random.choice(peliculas_filtradas)
    return jsonify(peli)


def obtener_nuevo_id():
    """
    Genera un nuevo ID para una película.

    Returns:
        - int(): El nuevo ID generado para la siguiente película.

    """
    if len(peliculas) > 0:
        ultimo_id = peliculas[-1]['id']
        return ultimo_id + 1
    else:
        return 1


def _filtrar_(genero):
    """
    Filtra las películas por género y devuelve una lista con las coincidencias.

    Parameters:
        genero(string): género por el que se desea filtrar.

    Returns:
        - list(): Una lista de películas que pertenecen al género especificado.

    """
    filtrados = []
    for pelicula in peliculas:
        if pelicula["genero"].lower() == genero.lower():
            filtrados.append(pelicula)
    return filtrados


def sugerir_pelicula_en_feriado(genero):
    """
    Devuelve una pelicula del genero y el siguiente feriado

    Parameters:
        genero(string): genero de la pelicula que se va a devolver

    Returns:
        - Un objeto JSON con un feriado y una pelicula y sus respectivas
          informaciones

    """
    # Obtener el próximo feriado
    next_holiday.fetch_holidays()
    feriado = next_holiday.holiday
    print(feriado)
    if not feriado:
        return jsonify({"error": "No se pudo obtener el próximo feriado"}), 500
    # Obtener una película del género especificado
    peliculas_filtradas = _filtrar_(genero)
    if not peliculas_filtradas:
        return jsonify({"error": "No hay peliculas con ese genero"}), 404
    pelicula_sugerida = random.choice(peliculas_filtradas)

    return jsonify({
        'holiday': feriado,
        'pelicula': pelicula_sugerida
    })


app.add_url_rule('/peliculas', 'obtener_peliculas',
                 obtener_peliculas, methods=['GET'])
app.add_url_rule('/peliculas/<int:id_pelicula>',
                 'obtener_pelicula', obtener_pelicula, methods=['GET'])
app.add_url_rule('/peliculas', 'agregar_pelicula',
                 agregar_pelicula, methods=['POST'])
app.add_url_rule('/peliculas/<int:id_pelicula>',
                 'actualizar_pelicula', actualizar_pelicula,
                 methods=['PUT'])
app.add_url_rule('/peliculas/<int:id_pelicula>',
                 'eliminar_pelicula', eliminar_pelicula,
                 methods=['DELETE'])
app.add_url_rule('/peliculas/genero/<string:genero>',
                 'filtrar_pelicula', filtrar_pelicula,
                 methods=['GET'])
app.add_url_rule('/peliculas/buscar/<string:palabra>',
                 'pelicula_con_palabra', pelicula_con_palabra,
                 methods=['GET'])
app.add_url_rule('/peliculas/random', 'sugerir_pelicula',
                 sugerir_pelicula, methods=['GET'])
app.add_url_rule('/peliculas/random/genero/<string:genero>',
                 'sugerir_pelicula_genero', sugerir_pelicula_genero,
                 methods=['GET'])
app.add_url_rule('/peliculas/feriado/genero/<string:genero>',
                 'sugerir_pelicula_en_feriado',
                 sugerir_pelicula_en_feriado, methods=['GET'])

if __name__ == '__main__':
    app.run()
