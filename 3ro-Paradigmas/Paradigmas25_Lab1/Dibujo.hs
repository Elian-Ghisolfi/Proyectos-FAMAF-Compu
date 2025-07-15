module Dibujo where

-- Definir el lenguaje via constructores de tipo
data Dibujo a = Basica a
              | Rotar (Dibujo a)
              | Rotar45 (Dibujo a)  
              | Espejar (Dibujo a)
              | Apilar Float Float (Dibujo a) (Dibujo a) 
              | Juntar Float Float (Dibujo a) (Dibujo a)
              | Encimar (Dibujo a) (Dibujo a)
                deriving (Show,Eq,Ord)


-- Composición n-veces de una función con sí misma.
comp :: (a -> a) -> Int -> a -> a
comp f 0 a = a
comp f (n) a = f (comp f (n-1) a) 


-- Rotaciones de múltiplos de 90.  
r180 :: Dibujo a -> Dibujo a
r180 dib = Rotar (Rotar dib)

r270 :: Dibujo a -> Dibujo a
r270 dib = Rotar (Rotar (Rotar dib))


-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = (Apilar 0 0 a b)


-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) a b = (Juntar 0 0 a b)


-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) a b = (Encimar a b)


-- Dadas cuatro dibujos las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = Juntar 1.0 1.0 (Apilar 1.0 1.0 (a) (c)) (Apilar 1.0 1.0 (b) (d)) 


-- Una dibujo repetido con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 d = d ^^^ (Rotar d) ^^^ r180 d ^^^ r270 d


-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a =  (Juntar 1.0 1.0 (Apilar 1.0 1.0  (a) (r180 a)) (Apilar 1.0 1.0 (Rotar a) (r270 a)))


-- Transfomar un valor de tipo a como una Basica.
pureDib :: a -> Dibujo a
pureDib a = Basica a 


-- map para nuestro lenguaje.
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Basica a)           = (Basica (f a))
mapDib f (Rotar a)            = mapDib f a
mapDib f (Rotar45 a)          = mapDib f a
mapDib f (Espejar a)          = mapDib f a
mapDib f (Apilar n1 n2 d1 d2) = (Apilar n1 n2 (mapDib f d1) (mapDib f d2))
mapDib f (Juntar n1 n2 d1 d2) = (Juntar n1 n2 (mapDib f d1) (mapDib f d2))
mapDib f (Encimar d1 d2)      = (Encimar (mapDib f d1) (mapDib f d2))


-- Funcion de fold para Dibujos a
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
           (Float -> Float -> b -> b -> b) -> 
           (Float -> Float -> b -> b -> b) -> 
           (b -> b -> b) ->
           Dibujo a -> b

foldDib fb fr fr45 fes fa fj fen (Basica a)           = fb a
foldDib fb fr fr45 fes fa fj fen (Rotar d)            = fr (foldDib fb fr fr45 fes fa fj fen d)
foldDib fb fr fr45 fes fa fj fen (Rotar45 d)          = fr45 (foldDib fb fr fr45 fes fa fj fen d)
foldDib fb fr fr45 fes fa fj fen (Espejar d)          = fes (foldDib fb fr fr45 fes fa fj fen d)
foldDib fb fr fr45 fes fa fj fen (Apilar n1 n2 d1 d2) = fa n1 n2 (foldDib fb fr fr45 fes fa fj fen d1) (foldDib fb fr fr45 fes fa fj fen d2)
foldDib fb fr fr45 fes fa fj fen (Juntar n1 n2 d1 d2) = fj n1 n2 (foldDib fb fr fr45 fes fa fj fen d1) (foldDib fb fr fr45 fes fa fj fen d2)
foldDib fb fr fr45 fes fa fj fen (Encimar d1 d2)      = fen (foldDib fb fr fr45 fes fa fj fen d1) (foldDib fb fr fr45 fes fa fj fen d2) 
