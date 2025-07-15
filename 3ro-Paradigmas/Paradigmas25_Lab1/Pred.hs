module Pred where

import Dibujo

type Pred a = a -> Bool

--Para la definiciones de la funciones de este modulo, no pueden utilizar
--pattern-matching, sino alto orden a traves de la funcion foldDib, mapDib 

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por el resultado de llamar a la función indicada por el
-- segundo argumento con dicha figura.
-- Por ejemplo, `cambiar (== Triangulo) (\x -> Rotar (Basica x))` rota
-- todos los triángulos.
cambiar :: Pred a -> a -> Dibujo a -> Dibujo a
cambiar pred a dib = mapDib (\pred -> a) dib

-- -- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred d = foldDib(\d -> (pred d))(\d -> d)(\d -> d)(\d -> d)(\n1 n2 d1 d2 -> (d1 || d2))(\n1 n2 d1 d2 -> (d1 || d2))(\d1 d2 -> (d1 || d2)) d

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib pred d = foldDib(\d -> (pred d))(\d -> d)(\d -> d)(\d -> d)(\n1 n2 d1 d2 -> (d1 && d2))(\n1 n2 d1 d2 -> (d1 && d2))(\d1 d2 -> (d1 && d2)) d

-- Hay 4 rotaciones seguidas.
esRot360 :: Pred (Dibujo a)
esRot360 dib =  (foldDib (\x -> 0) (\x -> x + 1) (\x -> (esCuatro x)) (\x -> (esCuatro x)) (\n1 n2 d1 d2 -> (esCuatro d1) + (esCuatro d2)) (\n1 n2 d1 d2 -> (esCuatro d1) + (esCuatro d2)) (\d1 d2 -> (esCuatro d1) + (esCuatro d2)) dib) >= 4

-- Funcion auxiliar para comprobar 4 rotaciones.
esCuatro :: Int -> Int
esCuatro n | n >= 4 = n 
           | n < 4  = 0

-- -- Hay 2 espejados seguidos.
esFlip2 :: Pred (Dibujo a)
esFlip2 dib = (foldDib (\x -> 0) (\x -> (esDos x)) (\x -> (esDos x)) (\x -> x + 1) (\n1 n2 d1 d2 -> (esDos d1) + (esDos d2)) (\n1 n2 d1 d2 -> (esDos d1) + (esDos d2)) (\d1 d2 -> (esDos d1) + (esDos d2)) dib) >= 2

-- Funcion auxiliar para comprobar 2 espejeados.
esDos :: Int -> Int
esDos n | n >= 2 = n
        | n < 2  = 0

data Superfluo = RotacionSuperflua 
               | FlipSuperfluo
               deriving (Show, Eq)



---- Chequea si el dibujo tiene una rotacion superflua
errorRotacion :: Dibujo a -> [Superfluo]
errorRotacion d | (esRot360 d) = RotacionSuperflua : []
                | otherwise = []

-- Chequea si el dibujo tiene un flip superfluo
errorFlip :: Dibujo a -> [Superfluo]
errorFlip d |(esFlip2 d) = FlipSuperfluo : []
            | otherwise = []
 
-- Aplica todos los chequeos y acumula todos los errores, y
-- sólo devuelve la figura si no hubo ningún error.
checkSuperfluo :: Dibujo a -> Either [Superfluo] (Dibujo a)
checkSuperfluo d | (acumularError d) /= [] = Left (acumularError d)
                 | (acumularError d) == [] = Right d

-- Funcion auxiliar para acumular errores en una lista Superfluo
acumularError :: Dibujo a -> [Superfluo]
acumularError d = errorFlip d ++ errorRotacion d
