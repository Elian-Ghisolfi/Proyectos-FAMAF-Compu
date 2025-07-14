-- 1a)

data Carrera = Matematica | Fisica | Computacion | Astronomia deriving (Eq, Ord)

-- 1b)

titulo :: Carrera -> String
titulo Matematica  = "Licenciatura en Matematica"
titulo Fisica      = "Licenciatura en Fisica"
titulo Computacion = "Licenciatura en Computacion"
titulo Astronomia  = "Licenciatura en Astronomia"

--1c), 2a)

data NotaBasica = Do | Re | Mi | Fa | Sol | La | Si deriving (Eq, Ord, Show)
--1d)

cifradoAmericano :: NotaBasica -> Char
cifradoAmericano Do  = 'C'
cifradoAmericano Re  = 'D'
cifradoAmericano Mi  = 'E'
cifradoAmericano Fa  = 'F'
cifradoAmericano Sol = 'G'
cifradoAmericano La  = 'A'
cifradoAmericano Si  = 'B' 

-- 3a) 

minimoElemento :: Ord a => [a] -> a 
minimoElemento [x] = x
minimoElemento (x:(y:xs))| (x <= y)  = minimoElemento (x:xs)
                         | otherwise = minimoElemento (y:xs) 

-- *Main> minimoElemento [4,5,9,-8,-9]
-- -9

-- 3b)

minimoElemento' :: (Ord a, Bounded a) => [a] -> a
minimoElemento' [] = minBound 
minimoElemento' zs = minimoElemento zs

-- *Main> minimoElemento' []::Int
-- -9223372036854775808

-- *Main> minimoElemento' [4,5,9,-8,-9]::Int
-- -9

-- *Main> minimoElemento' []::Char
-- '\NUL'

-- 3c)

-- *Main> minimoElemento [Fa, La, Sol, Re, Fa] 
-- Re

-- 4a)

-- Sinonimos de tipo
type Altura      = Int
type NumCamiseta = Int

-- Tipos algebr ́aicos sin par ́ametros (aka enumerados)
data Zona        = Arco | Defensa | Mediocampo | Delantera deriving (Eq, Show)
                 
data TipoReves   = DosManos | UnaMano deriving (Eq, Show)
                  
data Modalidad   = Carretera | Pista | Monte | BMX deriving (Eq, Show)
                 
data PiernaHabil = Izquierda | Derecha deriving (Eq, Show)
                  
-- Sinonimo
type ManoHabil   = PiernaHabil

-- Deportista -- es un tipo algebraico con constructores param ́etricos
data Deportista  =  Ajedrecista -- Constructor sin argumentos
                  | Ciclista Modalidad -- Constructor con un argumento
                  | Velocista Altura -- Constructor con un argumento
                  | Tenista TipoReves ManoHabil Altura -- Constructor con tres argumentos
                  | Futbolista Zona NumCamiseta PiernaHabil Altura   --Constructor con cuatros argumentos
                  deriving (Eq, Show)
-- 4b) Ciclista :: Modalidad -> Deportista 

-- 4c)

contar_velocistas :: [Deportista] -> Int
contar_velocistas [] = 0
contar_velocistas ((Velocista a):xs) = 1 + contar_velocistas xs
contar_velocistas (_:xs) = contar_velocistas xs

-- *Main> contar_velocistas [Velocista 185, Ajedrecista, Ciclista BMX, Velocista 144]
-- 2

-- *Main> contar_velocistas [Ajedrecista, Ciclista BMX]
-- 0

--4d) 

contar_futbolistas :: [Deportista] -> Zona -> Int
contar_futbolistas [] z = 0
contar_futbolistas ((Futbolista Arco _ _ _):xs) Arco             = 1 + contar_futbolistas xs Arco
contar_futbolistas ((Futbolista Defensa _ _ _):xs) Defensa       = 1 + contar_futbolistas xs Defensa 
contar_futbolistas ((Futbolista Mediocampo _ _ _):xs) Mediocampo = 1 + contar_futbolistas xs Mediocampo
contar_futbolistas ((Futbolista Delantera _ _ _):xs) Delantera   = 1 + contar_futbolistas xs Delantera
contar_futbolistas ((_):xs) z = contar_futbolistas xs z

-- *Main> contar_futbolistas [Futbolista Mediocampo 10 Derecha 185, Futbolista Defensa 15 Derecha 170, Ajedrecista, Ciclista BMX] Arco
-- 0

-- *Main> contar_futbolistas [Futbolista Mediocampo 10 Derecha 185, Futbolista Defensa 15 Derecha 170, Ajedrecista, Ciclista BMX] Defensa
-- 1

--4e)
igual_Zona :: Zona -> Deportista -> Bool
igual_Zona z (Futbolista zona _ _ _) = (zona == z)
igual_Zona z _ = False

contar_futbolistas2 :: [Deportista] -> Zona -> Int
contar_futbolistas2 xs z = length (filter (igual_Zona z) xs) 

-- *Main> contar_futbolistas2 [Futbolista Mediocampo 10 Derecha 185, Futbolista Defensa 15 Derecha 170, Ajedrecista, Ciclista BMX] Defensa
-- 1

-- *Main> contar_futbolistas2 [Futbolista Mediocampo 10 Derecha 185, Futbolista Defensa 15 Derecha 170, Ajedrecista, Ciclista BMX] Delantera
-- 0

--5a)

sonidoNatural :: NotaBasica -> Int
sonidoNatural Do  = 0
sonidoNatural Re  = 2
sonidoNatural Mi  = 4
sonidoNatural Fa  = 5
sonidoNatural Sol = 7
sonidoNatural La  = 9
sonidoNatural Si  = 11

-- *Main> sonidoNatural Do
-- 0

-- *Main> sonidoNatural Sol
-- 7

--5b)

data Alteracion = Bemol | Sostenido | Natural

--5c)

data NotaMusical = Nota NotaBasica Alteracion
                

--5d)

sonidoCromatico :: NotaMusical -> Int
sonidoCromatico (Nota n Bemol) = 1 + (sonidoNatural n) 
sonidoCromatico (Nota n Sostenido) = (sonidoNatural n) - 1                            
sonidoCromatico (Nota n Natural) = sonidoNatural n

-- *Main> sonidoCromatico (Nota Mi Bemol)
-- 5

-- *Main> sonidoCromatico (Nota Mi Sostenido)
-- 3

-- *Main> sonidoCromatico (Nota Mi Natural)
-- 4

--5e)

instance Eq NotaMusical 
    where
        n1 == n2 = (sonidoCromatico n1 == sonidoCromatico n2)
        
--5f)

instance Ord NotaMusical
    where
        n1 <= n2 = (sonidoCromatico n1 <= sonidoCromatico n2)

--6a)

-- data Maybe a = Nothing | Just a

primerElemento ::Num a => [a] -> Maybe a
primerElemento [] = Nothing
primerElemento xs = Just (head xs)

-- Ejemplo Teorico 2 (Datos Recursivos)

data Palabra = PVacia | Agregar Char Palabra

mostrar :: Palabra -> String
mostrar PVacia = ""
mostrar (Agregar l p) = l : mostrar p

--ej)
-- Con let construimos nuestra p (Palabra) y luego..
-- > let p = Agregar 'h' (Agregar 'o' (Agregar 'l' (Agregar 'a' PVacia)))
-- ... con nuestra funcion mostrar recursamos nuestro p
-- > mostrar p 
--  “hola”st

data ListaInt = LVacia | ConsI Int ListaInt

mostrarInt :: ListaInt -> [Int]
mostrarInt LVacia = []
mostrarInt (ConsI k lista) = k : mostrarInt lista

-- *Main> let lista = ConsI 1 (ConsI 2 (ConsI 3 (ConsI 4 (ConsI 5 LVacia))))
-- *Main> let lista' = LVacia

-- *Main> mostrarInt lista
-- [1,2,3,4,5]

-- *Main> mostrarInt lista'
-- []

data Lista a = Vacia | Cons a (Lista a)

mostrarLista :: Lista a -> [a]
mostrarLista Vacia = []
mostrarLista (Cons n lis) = n : mostrarLista lis

-- Main> let l  = Cons True Vacia
-- *Main> let l' = Cons (10::Int) (Cons 0 ( Cons 7 Vacia))
-- *Main> mostrarLista l
-- [True]
-- *Main> mostrarLista l'
-- [10,0,7]

--7

data Cola = VaciaC | Encolada Deportista Cola deriving Show
            

--7a1)

atender :: Cola -> Maybe Cola
atender VaciaC = Nothing
atender (Encolada _ c) = Just (c) -- Usamos _ para hacer pattern maching a todos los tipos Deportistas y sus parametros

-- *Main> atender (Encolada Ajedrecista (Encolada Ajedrecista (Encolada (Velocista 25) VaciaC)))
-- Just (Encolada Ajedrecista (Encolada (Velocista 25) VaciaC)) 

-- *Main> atender (Encolada Ajedrecista (Encolada Ajedrecista VaciaC))
-- Just (Encolada Ajedrecista VaciaC) 

-- *Main> atender (Encolada Ajedrecista VaciaC)
-- Just VaciaC

-- *Main> atender VaciaC
-- Nothing

--7a2)

encolar :: Deportista -> Cola -> Cola
encolar depor VaciaC = Encolada depor VaciaC
encolar depor (Encolada depors c) = Encolada depors (encolar depor c)

-- *Main> encolar (Ajedrecista) (Encolada (Velocista 170) (Encolada (Velocista 185) VaciaC))
-- Encolada (Velocista 170) (Encolada (Velocista 185) (Encolada Ajedrecista VaciaC))


--7a3)

busca :: Cola -> Zona -> Maybe Deportista
busca VaciaC zonaA = Nothing
busca (Encolada (Futbolista zonaB num pierna alt) c) zonaA | (zonaB == zonaA) = Just (Futbolista zonaB num pierna alt)
                                                           | (zonaB /= zonaA) = (busca c zonaA)
busca (Encolada _ c) zonaA = busca c zonaA                                                 

-- *Main> busca (Encolada Ajedrecista VaciaC) Delantera
-- Nothing

-- *Main> busca (Encolada Ajedrecista (Encolada (Velocista 185) (Encolada (Futbolista Arco 1 Derecha 198) (Encolada (Futbolista Defensa 6 Derecha 189 ) VaciaC)))) Defensa
-- Just (Futbolista Defensa 6 Derecha 189)

--8)

data ListaAsoc a b = Vacia' | Nodo a b ( ListaAsoc a b ) deriving (Show, Eq)
                    

type Diccionario = ListaAsoc String String
type Padron      = ListaAsoc Int String



--a)
type GuiaTel = ListaAsoc String Int

--b1)

la_long :: ListaAsoc a b -> Int
la_long Vacia' = 0
la_long (Nodo a b (colaList)) = 1 + (la_long (colaList))

-- *Main> la_long (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))
-- 3
-- *Main> la_long (Vacia')
-- 0

--b2)

la_concat :: ListaAsoc a b -> ListaAsoc a b -> ListaAsoc a b
la_concat Vacia' Vacia' = Vacia'
la_concat (Nodo a b (colaList)) Vacia' = (Nodo a b (colaList))
la_concat Vacia' (Nodo c d (colaList')) = (Nodo c d (colaList'))  

la_concat (Nodo a b (colaList)) lista2 = (Nodo a b (la_concat colaList lista2))

-- *Main> la_concat (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))) (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))
-- Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))))

-- *Main> la_concat (Vacia') (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))
-- Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))

--b3)

la_agregar :: Eq a => ListaAsoc a b -> a -> b -> ListaAsoc a b
la_agregar Vacia' a' b' = Nodo a' b' Vacia'
la_agregar (Nodo a b (colaList)) a' b' | (a' == a) = (Nodo a b' (colaList))
                                       | (a' /= a) = (Nodo a b (la_agregar colaList a' b'))  

-- *Main> la_agregar (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))) 'A' 'N'
-- Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' (Nodo 'A' 'N' Vacia')))

-- *Main> la_agregar (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))) 'a' 'N'
-- Nodo 'a' 'N' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))

--b4)

la_pares :: ListaAsoc a b -> [(a, b)]
la_pares Vacia' = []
la_pares (Nodo a b (colaList)) = (a, b) : (la_pares (colaList))

-- *Main> la_pares (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))
-- [('a','b'),('c','d'),('e','f')]

-- *Main> la_pares (Vacia')
-- []

--b5)

la_busca :: Eq a => ListaAsoc a b -> a -> Maybe b
la_busca Vacia' a' = Nothing
la_busca (Nodo a b (colaList)) a' | (a == a') = Just (b)
                                  | (a/= a') = la_busca ((colaList)) a'

-- *Main> la_busca (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))) 'e'
-- Just 'f'

-- *Main> la_busca (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))) 'r'
-- Nothing

--b6)

la_borrar :: Eq a => a -> ListaAsoc a b -> ListaAsoc a b
la_borrar a Vacia' = Vacia'
la_borrar a' (Nodo a b (colaList)) | (a' /= a) = Nodo a b (colaList)
                                   | (a' == a) =  la_borrar a' (colaList) 

-- *Main> la_borrar 'a' (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))
-- Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')

-- *Main> la_borrar 'r' (Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia')))
-- Nodo 'a' 'b' (Nodo 'c' 'd' (Nodo 'e' 'f' Vacia'))

-- *Main> la_borrar 'r' (Vacia')
-- Vacia'

-- -- -- -- -- -- -- -- -- -- -- --1)

-- --a) 

-- type Titulo =  String
-- type Artista = String
-- type Duracion = Int

-- data Genero = Rock | Blues | Pop | Jazz deriving Show

-- data Cancion =  Tema Titulo Artista Genero Duracion 
--               | Publicidad Duracion
--                 deriving Show
-- --b)

-- mismo_genero :: Genero -> Genero -> Bool
-- mismo_genero Rock Rock   = True
-- mismo_genero Blues Blues = True
-- mismo_genero Pop Pop     = True
-- mismo_genero Jazz Jazz   = True
-- mismo_genero _ _ = False

-- -- *Main> mismo_genero Pop Blues
-- -- False
-- -- *Main> mismo_genero Pop Pop
-- -- True

-- --c)

-- duracion_de :: Cancion -> Duracion
-- duracion_de (Tema _ _ _ d) = d

-- -- *Main> duracion_de (Tema "Nashee" "Lgante" Rock 180)
-- -- 180

-- --d)
-- instance Eq Cancion
--     where
--         c1 == c2 = duracion_de c1 == duracion_de c2

-- instance Ord Cancion
--     where
--         c1 <= c2 = duracion_de c1 <= duracion_de c2

-- --2)

-- --a)

-- solo_genero :: [Cancion] -> Genero -> [Titulo]
-- solo_genero [] gi = []
-- solo_genero ((Tema ti _ Pop _):cs) Pop = ti : solo_genero cs Pop 
-- solo_genero ((Tema ti _ Rock _):cs) Rock = ti : solo_genero cs Rock
-- solo_genero ((Tema ti _ Jazz _):cs) Jazz = ti : solo_genero cs Jazz
-- solo_genero ((Tema ti _ Blues _):cs) Blues = ti : solo_genero cs Blues
-- solo_genero ((Tema _ _ _ _):cs) gi = solo_genero cs gi

-- -- *Main> solo_genero [Tema "Nashee" "Lgante" Rock 180, Tema "TiniTini" "Lgante" Jazz 180, Tema "Nigga" "Lgante" Rock 180, Tema "Skeree" "Lgante" Rock 180] Rock
-- -- ["Nashee","Nigga","Skeree"]

-- -- *Main> solo_genero [Tema "Nashee" "Lgante" Rock 180, Tema "TiniTini" "Lgante" Jazz 180, Tema "Nigga" "Lgante" Rock 180, Tema "Skeree" "Lgante" Rock 180] Jazz
-- -- ["TiniTini"]

-- --3)
-- data ListaAsoc a b = Vacia| Nodo a b ( ListaAsoc a b ) deriving (Eq, Ord, Show)

-- la_suma_mayores :: (Num b, Ord b) => ListaAsoc a b -> b -> b
-- la_suma_mayores Vacia x = 0
-- la_suma_mayores (Nodo a b (colaList)) x | (b > x) = b + (la_suma_mayores (colaList) x)
--                                         | otherwise = la_suma_mayores colaList x

-- -- *Main> la_suma_mayores (Nodo 'a' 2 (Nodo 'b' 4 (Nodo 'c' 8 (Nodo 'd' 16 (Nodo 'e' 32 Vacia ))))) 30
-- -- 32

-- -- *Main> la_suma_mayores (Nodo 'a' 2 (Nodo 'b' 4 (Nodo 'c' 8 (Nodo 'd' 16 (Nodo 'e' 32 Vacia ))))) 10 
-- -- 48

-- -- *Main> la_suma_mayores (Nodo 'a' 2 (Nodo 'b' 4 (Nodo 'c' 8 (Nodo 'd' 16 (Nodo 'e' 32 Vacia ))))) 50
-- -- 0


-- -- -- -- --1)

-- --a) 

-- data Forma = Piedra | Papel | Tijera

-- le_gana :: Forma -> Forma -> Bool
-- le_gana Piedra Tijera = True
-- le_gana Papel Piedra = True
-- le_gana Tijera Papel = True
-- le_gana _ _ = False

-- -- *Main> le_gana Tijera Papel 
-- -- True
-- -- *Main> le_gana Tijera Tijera
-- -- False
-- -- *Main> le_gana Papel Tijera
-- -- False

-- --b)

-- type Nombre = String

-- data Jugador = Mano Nombre Forma

-- ganador :: Jugador -> Jugador -> Maybe Nombre
-- ganador (Mano n' f') (Mano n f)         | (le_gana f' f) = Just n'
--                                         | (le_gana f f') = Just n
--                                         | otherwise = Nothing

-- -- *Main> ganador (Mano "Ro" Tijera) (Mano "Elian" Papel)
-- -- Just "Ro"

-- -- *Main> ganador (Mano "Ro" Tijera) (Mano "Elian" Piedra)
-- -- Just "Elian"

-- -- *Main> ganador (Mano "Ro" Tijera) (Mano "Elian" Tijera)
-- -- Nothing

-- --2)

-- quien_jugo :: Forma -> [Jugador] -> [Nombre]
-- quien_jugo f [] = []
-- quien_jugo Tijera ((Mano nom Tijera):js) = nom : quien_jugo Tijera js 
-- quien_jugo Piedra ((Mano nom Piedra):js) = nom : quien_jugo Piedra js
-- quien_jugo Papel ((Mano nom Papel):js) = nom : quien_jugo Papel js
-- quien_jugo f (_:js) = quien_jugo f js

-- -- *Main> quien_jugo Tijera [Mano "Ro" Tijera, Mano "Jorge" Tijera, Mano "Elian" Papel]
-- -- ["Ro","Jorge"]

-- --3)

-- data NotaMusical = Do | Re | Mi | Fa | Sol | La | Si
-- data Figura = Negra | Corchea

-- data Melodia = Vacia' | Entonar NotaMusical Figura Melodia

-- contar_tiempos :: Melodia -> Int
-- contar_tiempos Vacia' = 0
-- contar_tiempos (Entonar n Negra (resto)) = 2 + contar_tiempos resto
-- contar_tiempos (Entonar n Corchea (resto)) = 1 + contar_tiempos resto