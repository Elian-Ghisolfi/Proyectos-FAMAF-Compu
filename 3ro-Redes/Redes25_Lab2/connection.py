# encoding: utf-8
# Revisión 2019 (a Python 3 y base64): Pablo Ventura
# Copyright 2014 Carlos Bederián
# $Id: connection.py 455 2011-05-01 00:32:09Z carlos $

import socket
from constants import (
    BAD_OFFSET,
    BAD_EOL,
    EOL,
    INVALID_ARGUMENTS,
    FILE_NAME_MAX_SIZE,
    FILE_NOT_FOUND,
    CODE_OK,
    INVALID_COMMAND,
    INTERNAL_ERROR,
    VALID_CHARS,
    error_messages,
)
from base64 import b64encode
import os


class Connection(object):
    """
    Conexión punto a punto entre el servidor y un cliente.
    Se encarga de satisfacer los pedidos del cliente hasta
    que termina la conexión.
    """

    def __init__(self, socket: socket.socket, directory: str):
        """
        Inicializa la conexión guardando el socket, el directorio y otros
        atributos necesarios para manejar los comandos del cliente.
        """
        self.socket = socket
        self.directory = directory
        self.buffer = 1024
        self.data = ""
        self.connection = True

    def parser_data(self, data_str: str) -> str:
        """
        Busca un comando correcto buffer de no encontrar ninguno o encontrar
        un final de line invalido devuelve un string vacio o una señal de error
         y esperamos a que el comando se complete.
        """
        self.data += data_str
        if "\n" in self.data:
            lines = self.data.split("\n")
            for i in range(
                len(lines) - 1
            ):  # No revisamos la última línea si está incompleta
                if not lines[i].endswith(
                    "\r"
                ):  # Encontramos un fin de línea incorrecto
                    return BAD_EOL
        if EOL in self.data:
            # divide el string cuando encuentra un EOL y lo guarda en command,
            # y en self.data el resto
            command, self.data = self.data.split(EOL, 1)
            return (
                command.strip()
            )  # devuelve el comando sin espacio al comienzo ni al final
        return ""

    def handle(self):
        """
        Atiende eventos de la conexión hasta que termina.
        """
        try:
            while self.connection:
                data = self.socket.recv(self.buffer)
                if not data:
                    break
                data_str = data.decode("ascii")
                head = self.parser_data(data_str)
                if head == BAD_EOL:
                    response = f"{BAD_EOL} {error_messages[BAD_EOL]}{EOL}"
                    self.socket.send(response.encode("ascii"))
                    self.connection = False
                if head != "" and head != BAD_EOL:
                    response = self.process_command(head)
                    self.socket.send(response.encode("ascii"))

        except ConnectionResetError:
            print("Error de conexión con el cliente")
        except BrokenPipeError:
            print("No se pudo enviar el mensaje: conexión cerrada.")
        finally:
            print("Cerrando conexión con el cliente.")
            self.socket.close()

    def process_command(self, command: str) -> str:
        """
        Procesa un comando y chequea que sea de la forma esperada, de ser asi
        llama a las distintas funciones que los ejecutan, de no ser asi
        devuelve un codigo de error y su tipo.
        """
        argumentos = command.split()
        cmd = argumentos[0]
        if cmd == "get_file_listing":
            if len(argumentos) == 1:
                return self.handle_get_file_listing()
            return (
                f"{INVALID_ARGUMENTS} "
                f"{error_messages[INVALID_ARGUMENTS]}"
                f"{EOL}"
            )
        if cmd == "get_metadata":
            if len(argumentos) == 2:
                filename = argumentos[1]
                if len(filename) >= FILE_NAME_MAX_SIZE:
                    return (
                        f"{FILE_NOT_FOUND} "
                        f"{error_messages[FILE_NOT_FOUND]}"
                        f"{EOL}"
                    )
                return self.handle_get_metadata(filename)
            return (
                f"{INVALID_ARGUMENTS} "
                f"{error_messages[INVALID_ARGUMENTS]}"
                f"{EOL}"
            )
        if cmd == "get_slice":
            if len(argumentos) == 4:
                filename = argumentos[1]
                try:
                    offset = int(argumentos[2])
                    size = int(argumentos[3])
                    return self.handle_get_slice(filename, offset, size)
                except ValueError:
                    return (
                        f"{INVALID_ARGUMENTS} "
                        f"{error_messages[INVALID_ARGUMENTS]}"
                        f"{EOL}"
                    )
            return (
                f"{INVALID_ARGUMENTS} "
                f"{error_messages[INVALID_ARGUMENTS]}"
                f"{EOL}"
            )
        if cmd == "quit":
            if len(argumentos) == 1:
                response = f"{CODE_OK} {error_messages[CODE_OK]}{EOL}"
                self.connection = False
                return response
            return (
                f"{INVALID_ARGUMENTS} "
                f"{error_messages[INVALID_ARGUMENTS]}"
                f"{EOL}"
            )
        return f"{INVALID_COMMAND} {error_messages[INVALID_COMMAND]}{EOL}"

    def handle_get_file_listing(self) -> str:
        """
        Ejecuta el comando get_file_listing, el cual nos devuelve los nombres
        de archivos actualmente disponibles.
        """
        try:
            files = os.listdir(self.directory)
            response = f"{CODE_OK} {error_messages[CODE_OK]}{EOL}"
            for filename in files:
                response += filename + EOL
            response += EOL
            return response
        except FileNotFoundError:
            return f"{FILE_NOT_FOUND} {error_messages[FILE_NOT_FOUND]}{EOL}"
        except Exception:
            self.connection = False
            return f"{INTERNAL_ERROR}{error_messages[INTERNAL_ERROR]}{EOL}"

    def handle_get_metadata(self, filename: str) -> str:
        """
        Ejecuta el comando get_metadata, el cual recibe el nombre de un archivo
        de existir nos devuelve su valor en bytes, de no existir nos indica un
        error
        """
        filepath = os.path.join(self.directory, filename)
        try:
            file_size = os.path.getsize(filepath)
            return f"{CODE_OK} {error_messages[CODE_OK]}{EOL}{file_size}{EOL}"
        except FileNotFoundError:
            return f"{FILE_NOT_FOUND} {error_messages[FILE_NOT_FOUND]}{EOL}"
        except Exception:
            self.connection = False
            return f"{INTERNAL_ERROR}{error_messages[INTERNAL_ERROR]}{EOL}"

    def handle_get_slice(self, filename: str, offset: int, size: int) -> str:
        """
        Ejecuta el comando get_slice, el cual recibe un nombre de archivo, un
        un byte de inicio y un size el cual indicara cuanto espera de ese
        archivo.
        """
        filepath = os.path.join(self.directory, filename)
        try:
            file_size = os.path.getsize(filepath)
            if (offset < 0) or (size < 0):
                return (
                    f"{INVALID_ARGUMENTS} "
                    f"{error_messages[INVALID_ARGUMENTS]}"
                    f"{EOL}"
                )
            if (offset + size) > file_size:
                return f"{BAD_OFFSET} {error_messages[BAD_OFFSET]}{EOL}"
            with open(filepath, "rb") as f:
                f.seek(offset)
                chunk = f.read(size)
                encoded_chunk = b64encode(chunk).decode("ascii")
                return (
                    f"{CODE_OK} "
                    f"{error_messages[CODE_OK]}"
                    f"{EOL}{encoded_chunk}{EOL}"
                )
        except FileNotFoundError:
            return f"{FILE_NOT_FOUND} {error_messages[FILE_NOT_FOUND]}{EOL}"
        except Exception:
            self.connection = False
            return f"{INTERNAL_ERROR} {error_messages[INTERNAL_ERROR]}{EOL}"
