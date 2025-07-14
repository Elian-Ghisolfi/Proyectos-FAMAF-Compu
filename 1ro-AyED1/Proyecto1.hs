    -- 1a)
esCero :: Int -> Bool
esCero x | x == 0 = True
         | otherwise = False 
-- ej) *Main> esCero 0
-- True
-- *Main> esCero 1
-- False


-- 1b)
esPositivo :: Int -> Bool
esPositivo x | x > 0 = True
             | otherwise = False
-- ej) *Main> esPositivo 4
-- True
-- *Main> esPositivo 0
-- False


 -- 1c)
esVocal :: Char -> Bool
esVocal x | ((x == 'a') || (x == 'e') || (x=='i') || (x == 'o') || (x == 'u')) = True
          | otherwise = False
-- ej) *Main> esVocal 'a'
-- True
-- *Main> esVocal 'b'
-- False


-- 1d)
valorAbsoluto :: Int -> Int
valorAbsoluto x | x >= 0 = x
                | x < 0 = (x * (-1)) 
-- ej) *Main> valorAbsoluto 5
-- 5
-- *Main> valorAbsoluto (-10)
-- 10


-- 2a)
paraTodo :: [Bool] -> Bool
paraTodo [] = True
paraTodo (x:xs) | x == True = paraTodo (xs)
                | otherwise = False
-- ej) *Main> paraTodo [True,False,True]
-- False
-- *Main> paraTodo [True,True,True]
-- True

-- 2a')
paraTodo' :: [Bool] -> Bool
paraTodo' [] = True
paraTodo' (x:xs) = x == True && paraTodo' xs
-- ej) *Main> paraTodo' [True,False,True]
-- False
-- *Main> paraTodo' [True,True,True]
-- True


-- 2b)
sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs
-- ej) *Main> promedio [1,6,2,7]
-- 8
-- *Main> promedio [21,61,24,9]
-- 57


-- 2c)
productoria :: [Int] -> Int
productoria [] = 1
productoria (x:xs) = x * productoria xs
-- ej) *Main> promedio [1,6,2,7]
-- 8
-- *Main> promedio [21,61,24,9]
-- 57


-- 2d)
factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial (x-1)
-- ej) *Main> promedio [1,6,2,7]
-- 8
-- *Main> promedio [21,61,24,9]
-- 57


-- 2e)
promedio :: [Int] -> Int
promedio (x:xs) = div (sumatoria (x : xs)) 2
-- ej) *Main> promedio [1,6,2,7]
-- 8
-- *Main> promedio [21,61,24,9]
-- 57


-- 3)
pertenece :: Int -> [Int] -> Bool
pertenece n [] = True
pertenece n (x:xs)| n == x = True 
                  | otherwise = pertenece n (xs)
--ej) *Main> pertenece 5 [1,2,4]
-- False
-- *Main> pertenece 5 [1,2,5,7]
-- True


-- 3')
pertenece' :: Int -> [Int] -> Bool
pertenece' n [] = False
pertenece' n (x:xs)= n == x || pertenece' n (xs)
--ej) *Main> pertenece' 5 [1,2,4]
-- False
-- *Main> pertenece' 5 [1,2,5,7]
-- True


-- 4a)
paraTodo'' :: [a] -> (a -> Bool) -> Bool
paraTodo'' [] f = True
paraTodo'' (x:xs) f = f (x) && paraTodo'' xs f
-- ej) *Main> paraTodo'' [1,2,4,0] esPositivo 
-- False
-- *Main> paraTodo'' [1,2,4,7] esPositivo 
-- True


-- 4b)
existe' :: [a] -> (a -> Bool) -> Bool
existe' [] f = False
existe' (x:xs) f = f (x) || existe' xs f

existe'' :: [a] -> (a -> Bool) -> Bool --Para 6b) y 6d)
existe'' (xs) f = existe' (xs) f
-- ej) *Main> existe'' [0,3,4,(-2)] esPositivo 
-- True
-- *Main> existe'' [0,(-2)] esPositivo 
-- False


-- 4c)
sumatoria' :: [a] -> (a -> Int) -> Int
sumatoria' [] f = 0
sumatoria' (xs) f = sumatoria (map f xs)
-- ej) *Main> sumatoria' [1,3,4,5] factorial
-- 151
-- *Main> sumatoria' [5,2,6,5] factorial
-- 962


-- 5) 
paraTodo''' :: [a] -> (a -> Bool) -> Bool
paraTodo''' xs f = paraTodo'' (xs) f
-- ej) *Main> paraTodo''' [0,0,0,0] esCero 
-- True
-- *Main> paraTodo''' [0,0,0,1] esCero 
-- False


-- 6a)
esPar :: Int -> Bool
esPar x = x `mod` 2 == 0

todosPares :: [Int] -> Bool
todosPares [] = True
todosPares (xs) = paraTodo''' (xs) esPar
-- ej) *Main> todosPares  [2,1,6,4]
-- False
-- *Main> todosPares  [2,8,6,4]
-- True


-- 6b)
esMultiplo :: Int -> Int -> Bool
esMultiplo y x = x `mod` y == 0 

hayMultiplo :: Int -> [Int] -> Bool
hayMultiplo y (xs) = existe'' xs (esMultiplo y)
-- ej) *Main> hayMultiplo 2 [1,3,5,11]
-- False
-- *Main> hayMultiplo 2 [1,3,5,10]
-- True


-- 6c)
cuadrados :: Int -> Int
cuadrados x = x^2

sumaCuadrados :: Int -> Int
sumaCuadrados 0 = 0
sumaCuadrados x = sumatoria' ([0..(x-1)]) cuadrados
-- ej) *Main> sumaCuadrados 3
-- 5
-- *Main> sumaCuadrados 120
-- 568820


-- 6d)
esDivisor :: Int -> Int -> Bool
esDivisor y x = y `mod` x == 0

existeDivisor :: Int -> [Int] -> Bool
existeDivisor y [] = False
existeDivisor y xs = existe'' xs (esDivisor y)
-- ej) *Main> existeDivisor 2 [3,5,8,9]
-- False
-- *Main> existeDivisor 16 [3,5,8,9]
-- True


-- 6e)
esPrimo :: Int -> Bool
esPrimo n = ((existeDivisor n [2..(n-1)]) || (n<1)) == False
-- ej) *Main> esPrimo 4
-- False
-- *Main> esPrimo 7
-- True


--6f)
factorial' :: Int -> Int
factorial' x = factorial x
-- ej) *Main> factorial' 5
-- 120
-- *Main> factorial' 3
-- 6


-- 6g)
soloPrimos :: [Int] -> [Int]
soloPrimos (xs) = filter esPrimo xs

multiplicaPrimos :: [Int] -> Int
multiplicaPrimos (xs) = productoria (soloPrimos xs)
-- ej) *Main> multiplicaPrimos [0,4,3,5]
-- 15
-- *Main> multiplicaPrimos [1,4,3,5]
-- 15
-- *Main> multiplicaPrimos [1,3,7,5]
-- 15


-- 6h) 
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib x =  fib (x-1) + fib (x-2)


esFib :: Int -> Bool
esFib n = pertenece' n (map fib [0..(n+1)])
-- ej) *Main> esFib 2
-- True
-- *Main> esFib 3
-- True
-- *Main> esFib 4
-- False


-- 6i)
todosFib :: [Int] -> Bool
todosFib [] = True
todosFib (xs) = paraTodo' (map esFib (xs))

todosFib' :: [Int] -> Bool
todosFib' [] = True
todosFib' (xs) = paraTodo''' (map esFib (xs)) id 
-- ej) *Main> todosFib [1,2,3,4,5]
-- False
-- *Main> todosFib [1,2,3,5,8]
-- True

-- 7) map: toma una lista [a] y a cada elemento de la misma le aplica una funcion f (a->b) tal que te devuelve una lista [b].
--    filter: toma una lista [a] y te devuelve otra lista resultado de aplicarle a cada elemento de la misma una funcion f (a -> Bool)
--    map succ [1, -4, 6, 2, -8], donde succ n = n+1. Equivale a una lista = [2, -3,7,3, -7]
--    La expresion filter esPositivo [1,(-4), 6, 2,(-8)]. Devuelve la lista [1,6,2]

-- 8a) 
doble :: [Int] -> [Int]
doble [] = []
doble (x:xs) = (x*2): doble xs
-- ej) *Main> doble [1,2,3,4,5]
-- [2,4,6,8,10]
-- *Main> doble [11,22,33,44,55]
-- [22,44,66,88,110]

-- 8b)
auxdoble :: Int -> Int
auxdoble 0 = 0
auxdoble x = x*2

doble' :: [Int] -> [Int] 
doble' xs =  map auxdoble xs
-- ej) *Main> doble' [1,2,3,4,5]
-- [2,4,6,8,10]
-- *Main> doble' [11,22,33,44,55]
-- [22,44,66,88,110]

-- 9a)
filterPrimos :: [Int] -> [Int]
filterPrimos [] = []
filterPrimos (x:xs)| esPrimo x = x : filterPrimos xs
                    | otherwise = filterPrimos xs

-- -- ej) *Main> filterPrimos [4,6,8]
-- []
-- *Main> filterPrimos [1,2,4,6,8]
-- [1,2]

-- 9b)
-- soloPrimos :: [Int] -> [Int]
-- soloPrimos (xs) = filter esPrimo xs

-- 9c) 
-- Ya esta mejorado

-- 10a)

primIgualesA :: Eq a => a -> [a] -> [a]
primIgualesA n [] = []
primIgualesA n (x:xs) | n == x = x : primIgualesA n xs
                      | n /= x = []

-- ej) *Main> primIgualesA 'a' "aaadaa"
-- "aaa"
-- *Main> primIgualesA 3 [3,3,4,1]
-- [3,3]
-- *Main> primIgualesA 3 [4,3,3,4,1]
-- []
-- *Main> primIgualesA 3 []
-- []

-- 10b)
iguales :: Eq a => a -> a -> Bool
iguales n x = (x==n)

primIgualesA' :: Eq a => a -> [a] -> [a]
primIgualesA' n [] = []
primIgualesA' n xs = takeWhile  (iguales n) xs

-- *Main> primIgualesA' 'a' "aaadaa"
-- "aaa"
-- *Main> primIgualesA' 3 [3,3,4,1]
-- [3,3]
-- *Main> primIgualesA' 3 [4,3,3,4,1]
-- []
-- *Main> primIgualesA' 3 []
-- []

--11a)
primIguales :: Eq a => [a] -> [a]
primIguales [] = []
primIguales [x] = [x]
primIguales (x:(y:xs)) | x == y = x : primIguales (y:xs)
                       | x /= y = [x]

-- *Main> primIguales [3,3,4,1]
-- [3,3]
-- *Main> primIguales [4,3,4,1]
-- [4]
-- *Main> primIguales []
-- []
-- *Main> primIguales "aaadaa"
-- "aaa"

-- 11b)
primIguales' :: Eq a => [a] -> [a]
primIguales' xs = primIgualesA' (head xs) xs

-- *Main> primIguales' []
-- []
-- *Main> primIguales' "aaadaa"
-- "aaa"
-- *Main> primIguales' [4,3,4,1] 
-- [4]
-- *Main> primIguales' [3,3,4,1] 
-- [3,3]

-- 11b')
primIguales'' :: Eq a => [a] -> [a]
primIguales'' [] = []
primIguales'' (x:xs) = primIgualesA' x (x:xs)

-- *Main> primIguales' []
-- []
-- *Main> primIguales' "aaadaa"
-- "aaa"
-- *Main> primIguales' [4,3,4,1] 
-- [4]
-- *Main> primIguales' [3,3,4,1] 
-- [3,3]