# Pruebas para `GET /peliculas/<id>`
# Caso de exito:
curl http://127.0.0.1:5000/peliculas/2
# Caso de error:
curl http://127.0.0.1:5000/peliculas/500

# Pruebas para `PUT /peliculas/<id>`
# - Caso de exito:
curl -X PUT http://127.0.0.1:5000/peliculas/2\
     -H "Content-Type: application/json" \
     -d '{
           "titulo": "Nuevo Título",
           "genero": "Nuevo Género"
         }'
# - Caso de error:
curl -X PUT http://127.0.0.1:5000/peliculas/2000\
     -H "Content-Type: application/json" \
     -d '{
           "titulo": "Nuevo Título",
           "genero": "Nuevo Género"
         }'

# Pruebas para `DELETE /peliculas/<id>`
# - Caso de exito:
curl -X DELETE "http://127.0.0.1:5000/peliculas/2"
# - Caso de error:
curl -X DELETE "http://127.0.0.1:5000/peliculas/2000"

# Pruebas para `GET /peliculas/genero/<genero>`
# - Caso de exito:
curl http://127.0.0.1:5000/peliculas/genero/Drama
# - Caso de error:
curl http://127.0.0.1:5000/peliculas/genero/Miedo

# Pruebas para `GET /peliculas/buscar/<palabra>`
# - Caso de exito:
curl http://127.0.0.1:5000/peliculas/buscar/The
# - Caso de error: 
curl http://127.0.0.1:5000/peliculas/buscar/dia

# Pruebas para `GET /peliculas/sugerir`
curl http://127.0.0.1:5000/peliculas/random

# Pruebas para `GET /peliculas/sugerir/<genero>`
# - Caso de exito:
curl http://127.0.0.1:5000/peliculas/random/genero/Drama
# - Caso de error:
curl http://127.0.0.1:5000/peliculas/random/genero/Terror


# Prueba para `GET /peliculas/feriado/genero/<genero>`
# - Caso de exito:
curl http://127.0.0.1:5000/peliculas/feriado/genero/Drama

# - Caso de error:
curl http://127.0.0.1:5000/peliculas/feriado/genero/Terror

