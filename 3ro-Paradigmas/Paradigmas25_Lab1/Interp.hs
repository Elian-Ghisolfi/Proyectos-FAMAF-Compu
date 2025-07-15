module Interp where

import Graphics.Gloss

import Graphics.Gloss.Data.Vector

import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo

-- Gloss provee el tipo Vector y Picture.
type ImagenFlotante = Vector -> Vector -> Vector -> Picture
type Interpretacion a = a -> ImagenFlotante


mitad :: Vector -> Vector
mitad = (0.5 V.*)

-- Interpretaciones de los constructores de Dibujo
-- Significado variables utilizadas:
-- w = width (ancho) 
-- h = height (altura) 
-- d = punto de origen


--interpreta el operador de rotacion
interp_rotar :: ImagenFlotante -> ImagenFlotante
interp_rotar f d w h = (f (d V.+ w) h (V.negate w))
-- d V.+ w: Mueve el origen a la derecha (donde estaba el borde derecho de la figura)
-- h: el nuevo vector horizontal (antes vertical)
-- V.negate w: Nuevo vector vertical 


-- --interpreta el operador de rotacion 45
interp_rotar45 :: ImagenFlotante -> ImagenFlotante
interp_rotar45 r45 d w h = (r45 (d V.+ (mitad (w V.+ h))) (mitad (w V.+ h)) (mitad (h V.- w) ))
-- d V.+ mitad (w V.+ h): Mueve la figura al centro, el punto medio es la diagonal que une el vertice
--     superior izq con el superior der
-- mitad (w V.+ h): Vector que apunta en diagonal (se divide en 2 ya que al sumar los vectores su modulo crece)
-- mitad (h V.- w): Vector ortogonal a w + h


-- --interpreta el operador de espejar
interp_espejar :: ImagenFlotante -> ImagenFlotante
interp_espejar esp d w h = (esp(d V.+ w) (V.negate w) h)
-- d V.+ w: Mueve el origen al extremo derecho del dibujo
-- v.negate W: Invierte la direccion horizontal (El dibujo va de der a izq)
-- el eje vertical (h) se mantiene igual


-- --interpreta el operador de apilar
interp_apilar :: Float -> Float -> ImagenFlotante -> ImagenFlotante -> ImagenFlotante
interp_apilar m n f g d w h = pictures ([(f (d V.+ (n/(m+n)) V.* h) w ((m/(m+n)) V.* h))] ++ [(g d w ((n/(m+n)) V.* h))])
-- (m/(m+n) V.* h): Se modifica el alto para ajustarlo a la nueva division de la pantalla
-- ((n/(m+n)) V.* h): se reduce la altura del dibujo en base a la fracción n/(m+n) pero no cambia punto de origen
-- g queda abajo


--interpreta el operador de juntar
interp_juntar :: Float -> Float -> ImagenFlotante -> ImagenFlotante -> ImagenFlotante
interp_juntar m n f g d w h = pictures ([(f d ((m/(n+m)) V.* w) h)] ++ [(g (d V.+ ((m/(n+m)) V.* w)) ((n/(n+m)) V.* w) h)])
-- (m/(n+m)) V.* w : Solo se modifica el ancho de la imagen f
--En g se modifican tanto punto de origen (d V.+ (m/(n+m)) V.* w) como ancho (n/(n+m))*w

--interpreta el operador de encimar
interp_encimar :: ImagenFlotante -> ImagenFlotante -> ImagenFlotante
interp_encimar f g d w h = pictures ([(f d w h)] ++ [(g d w h)])
-- Simplemente se "concatenan" ambas imagenes

--interpreta cualquier expresion del tipo Dibujo a
--utilizar foldDib
interp :: Interpretacion a -> Dibujo a -> ImagenFlotante
interp fun dib = foldDib (\x -> fun x)(\x -> interp_rotar x)(\x -> interp_rotar45 x)(\x -> interp_espejar x)(\a b x y -> interp_apilar a b x y)(\a b x y -> interp_juntar a b x y)(\x y -> interp_encimar x y) dib