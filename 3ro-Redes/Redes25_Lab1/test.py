import requests

# Obtener todas las películas
response = requests.get('http://localhost:5000/peliculas')
peliculas = response.json()
print("Películas existentes:")
for pelicula in peliculas:
    print(f"ID: {pelicula['id']}, Título: {pelicula['titulo']}, Género: {pelicula['genero']}")
print()

# Agregar una nueva película
nueva_pelicula = {
    'titulo': 'Pelicula de prueba',
    'genero': 'Acción'
}
response = requests.post('http://localhost:5000/peliculas', json=nueva_pelicula)
if response.status_code == 201:
    pelicula_agregada = response.json()
    print("Película agregada:")
    print(f"ID: {pelicula_agregada['id']}, Título: {pelicula_agregada['titulo']}, Género: {pelicula_agregada['genero']}")
else:
    print("Error al agregar la película.")
print()

# Obtener detalles de una película específica
id_pelicula = 1  # ID de la película a obtener
response = requests.get(f'http://localhost:5000/peliculas/{id_pelicula}')
if response.status_code == 200:
    pelicula = response.json()
    print("Detalles de la película:")
    print(f"ID: {pelicula['id']}, Título: {pelicula['titulo']}, Género: {pelicula['genero']}")
else:
    print("Error al obtener los detalles de la película.")
print()

# Actualizar los detalles de una película
id_pelicula = 1  # ID de la película a actualizar
datos_actualizados = {
    'titulo': 'Nuevo título',
    'genero': 'Comedia'
}
response = requests.put(f'http://localhost:5000/peliculas/{id_pelicula}', json=datos_actualizados)
if response.status_code == 200:
    pelicula_actualizada = response.json()
    print("Película actualizada:")
    print(f"ID: {pelicula_actualizada['id']}, Título: {pelicula_actualizada['titulo']}, Género: {pelicula_actualizada['genero']}")
else:
    print("Error al actualizar la película.")
print()

# Eliminar una película
id_pelicula = 1  # ID de la película a eliminar
response = requests.delete(f'http://localhost:5000/peliculas/{id_pelicula}')
if response.status_code == 200:
    print("Película eliminada correctamente.")
else:
    print("Error al eliminar la película.")
print()

# Obtener peliculas por palabra
name_pelicula='F'
response = requests.get(f'http://localhost:5000/peliculas/buscar/{name_pelicula}')
if response.status_code == 200:
    peliculas = response.json()
    print("Peliculas encontradas con",name_pelicula,":")
    for pelicula in peliculas:  # Iteramos sobre la lista de películas
        print(f"ID: {pelicula['id']}, Título: {pelicula['titulo']}, Género: {pelicula['genero']}")
else:
    print("No se encontro pelicula con esa palabra.")
print()

# Obtener lista de peliculas por genero
genero="Ciencia ficción"
response = requests.get(f'http://localhost:5000/peliculas/genero/{genero}')
if response.status_code == 200:
    peliculas = response.json()
    print("Lista de peliculas con el genero",genero,":")
    for pelicula in peliculas:
        print(f"ID: {pelicula['id']}, Título: {pelicula['titulo']}, Género: {pelicula['genero']}")
else:
    print("No te pudimos sugerir una peli esta vez.")
print()

# Sugerir pelicula random
response = requests.get(f'http://localhost:5000/peliculas/random')
if response.status_code == 200:
    pelicula = response.json()
    print("Pelicula random sugerida para ver:")
    print(f"ID: {pelicula['id']}, Título: {pelicula['titulo']}, Género: {pelicula['genero']}")
else:
    print("No te pudimos sugerir una peli esta vez.")
print()

# Sugerir pelicula random por genero
genero='Crimen'
response = requests.get(f'http://localhost:5000/peliculas/random/genero/{genero}')
if response.status_code == 200:
    pelicula = response.json()
    print("Pelicula random sugerida para ver del genero",genero,":")
    print(f"ID: {pelicula['id']}, Título: {pelicula['titulo']}, Género: {pelicula['genero']}")
else:
    print("No te pudimos sugerir una peli esta vez.")
print()

# Sugerir una pelicula para el proximo feriado
genero='Acción'
response = requests.get(f'http://localhost:5000/peliculas/feriado/genero/{genero}')
if response.status_code == 200:
    datos = response.json()
    pelicula=datos['pelicula']
    feriado=datos['holiday']
    print("Pelicula random sugerida para ver del genero",genero," el proximo feriado:")
    print(f"El proximo feriado es el: {feriado['dia']}/{feriado['mes']}, con motivo: {feriado['motivo']},"
    f"te sugiero ver la pelicula de",genero,pelicula['titulo'])
else:
    print("No te pudimos sugerir una peli esta vez.")
print()

