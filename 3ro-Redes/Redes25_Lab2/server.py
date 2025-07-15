#!/usr/bin/env python
# encoding: utf-8
# Revisión 2019 (a Python 3 y base64): Pablo Ventura
# Revisión 2014 Carlos Bederián
# Revisión 2011 Nicolás Wolovick
# Copyright 2008-2010 Natalia Bidart y Daniel Moisset
# $Id: server.py 656 2013-03-18 23:49:11Z bc $

import optparse
import socket
import os
from connection import Connection
import sys
from constants import DEFAULT_ADDR, DEFAULT_PORT, DEFAULT_DIR
from concurrent.futures import ThreadPoolExecutor


class Server(object):
    """
    El servidor, que crea y atiende el socket en la dirección y puerto
    especificados donde se reciben nuevas conexiones de clientes.
    """

    def __init__(
        self,
        addr: str = DEFAULT_ADDR,
        port: int = DEFAULT_PORT,
        directory: str = DEFAULT_DIR,
    ) -> None:
        """
        Inicializa el servidor seteando la dirección, puerto y directorio,
        y lo deja listo para aceptar conexiones entrantes.
        """
        print("Serving %s on %s:%s." % (directory, addr, port))
        if not os.path.isdir(directory):
            os.mkdir(directory)
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.directory = directory
        self.socket.bind((addr, port))
        print("Servidor iniciado")
        self.socket.listen()

    def serve(self):
        """
        Loop principal del servidor. Se aceptan hasta 4 conexiones en 
        simultaneo, cuando se desconecta un cliente de estos 4 aceptamos uno
        nuevo.
        """
        with ThreadPoolExecutor(max_workers=4) as executor:
            while True:
                print("En loop")
                conn, addr = self.socket.accept()
                print(f"Conexión desde {addr[0]}")
                connect = Connection(conn, self.directory)
                executor.submit(connect.handle)


def main():
    """Parsea los argumentos y lanza el server"""

    parser = optparse.OptionParser()
    parser.add_option(
        "-p", "--port",
        help="Número de puerto TCP donde escuchar",
        default=DEFAULT_PORT
    )
    parser.add_option(
        "-a", "--address",
        help="Dirección donde escuchar",
        default=DEFAULT_ADDR
    )
    parser.add_option(
        "-d", "--datadir", help="Directorio compartido", default=DEFAULT_DIR
    )

    options, args = parser.parse_args()
    if len(args) > 0:
        parser.print_help()
        sys.exit(1)
    try:
        port = int(options.port)
    except ValueError:
        sys.stderr.write(
            "Numero de puerto invalido: %s\n" % repr(options.port)
        )
        parser.print_help()
        sys.exit(1)

    server = Server(options.address, port, options.datadir)
    server.serve()


if __name__ == "__main__":
    main()
