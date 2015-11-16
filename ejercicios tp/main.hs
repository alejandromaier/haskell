module Main where

import System.Process
import Data.List
import qualified VideoClub   as V
import qualified Cliente     as C
import qualified Pelicula    as P
import qualified Alquiler    as A


-- Listas

-- listar_clientes            = C.listar_clientes
-- listar_peliculas           = P.listar_peliculas
-- listar_peliculas_vc        = P.listar_peliculas_vc
-- listar_peliculas_na        = P.listar_peliculas_na
-- listar_categorias          = P.listar_categorias
-- listar_peliculas_categoria = P.menu
-- listar_videoclubs          = V.listar_videoclubs

-- Resolucion ejercicios

--1)--------- Clientes, que devuelve una lista con los clientes registrados en el videoclub.
clientes_videoclub = V.listar_cvideoclub
-------------
--2)--------- Películas, que devuelve una lista con las películas que están en el catálogo del videoclub, independientemente de si esta disponible o no.
peliculas_videoclub = V.listar_pvc
-------------
--3)--------- CantidadDeCopiasPelicula, que devuelve cuantas copias de una película tiene el videoclub (esta función se indefine, o sea da error, si la película no pertenece al catalogo del videoclub).
listar_copias_pelicula = V.copias_p
-------------
--4)--------- CantidadDeCopias, que devuelve una lista con las películas y cuantas copias  tiene el videoclub.
listar_cant_copias_pelicula = V.copias_peliculas
-------------
--5)--------- PelículasNoAlquiladas, que devuelve una lista de películas que no han sido alquiladas.
listar_peliculas_na = P.peliculas_na
-------------
--6)--------- peliculasPorCategoria, que devuelve un listado de películas por categoría seleccionada.*
listar_peliculas_por_categoria = P.listarPeliculasPorCategoria P.peliculas
-------------
--7)--------- PelículasAlquiladasPorCliente, que devuelve una lista de películas que el cliente tiene alquiladas en el videoclub 
--            (esta función se indefine si el cliente no esta registrado en el videoclub). 
--            El cliente puede alquilar más de una copia de la misma película.
listar_peliculas_alquiladas_cliente = A.alquileresCliente
-------------
--8)--------- Alquiló, que indica si un cliente de un videoclub alquiló una película en particular.
alquilo = A.alquiloPelicula
-------------
--9)--------- CopiasAlquiladas, que devuelve la cantidad de copias de la película dada que están alquiladas en un videoclub.
copias_en_videoclub = V.copias_alquiladas
-------------
--10)-------- DisponibleParaAlquilar, que indica si una película esta disponible para ser alquilada en el videoclub 
--            (por ejemplo, una película puede estar en un videoclub pero no estar disponible porque todas sus copias están alquiladas, 
--            o no estar disponible porque no esta en el catálogo).
disponible_para_alquilar = V.disponibleParaAlquilar
-------------
---11)------- CategoriasDisponibles, que devuelve una lista de categorías disponibles en el videoclub.*
categorias_disponibles_vc = V.categoriasPeliculas
-------------
---12)------- disponibleEnLaRed, que dice si la película está disponible en al menos alguno de los videoclubs de la red.
disponible_en_la_red = V.disponibleEnLaRed
-------------
---13)------- masAlquiladaEnLaRed, que devuelve la película más alquilada en todos los videoclubs de la red.
mas_alquilada_en_la_red = P.masAlquiladaEnLaRed
-------------
---14)------- ClientesRaros, que devuelve la lista de clientes que tienen alquilada la misma película en distintos videoclubs.
clientes_raros = A.clientesRaros
-------------
---15)------- CantidadTitulosOriginales, que devuelve una lista con las películas de todos los videoclubs, sin repetidos.
cantidad_titulos_originales = P.titulosOriginales
-------------
---16)------- peliculasDisponibles, que devuelve una lista con las películas disponibles, de entre los videoclubs de la red, para alquilar y el número de copias.
peliculas_disponibles = P.te_cuento_cual
-------------
---17)-------- peliculasDisponiblesPorCategoria, que devuelve una lista con las películas disponibles por categoría seleccionada,
--            de entre los videoclubs de la red, para alquilar y el número de copias.*
peliculas_disponibles_categoria = P.peliculasDisponiblesCategoria
-------------
---18)------- CantidadDePeliculasPorCategoria, devuelve un listado de categorías con la cantidad de películas que hay dentro de esa clasificación.*
cantidad_peliculas_categoria = P.cantPelisCategoria
-------------
---19)------- BuscarPeli, devuelve un listado con los videoclubs que tienen una determinada película.*
buscar_peli = V.buscarPeli
-------------
-- cliente_menu   = C.menu
-- pelicula_menu  = P.menu
-- videoclub_menu = V.menu
-- alquiler_menu  = A.menu

-- clientes   = C.clientes
-- peliculas  = P.peliculas
-- videoclubs = V.videoclubs
-- alquileres = A.alquileres

-- salir = undefined

-- lista_ejercicios :: IO ()
-- lista_ejercicios = putStrLn "Lista de ejercicios"
                   

-- -- clearScreen :: IO ()
-- -- clearScreen = putStrLn ""

-- opciones :: [(Int, (String, IO ()))]
-- opciones = zip [1..5] [
--     ("Listas de los ejercicios", lista_ejercicios)
--     , ("Listar videoclubs",listar_videoclubs)
--     , ("Listas peliculas de todos los videoclubs",listar_peliculas)
--     , ("Listar todos los clientes",listar_clientes)
--     , ("Salir",salir)]

-- menu :: IO ()
-- menu = do
--       -- clearScreen
--       putStrLn "Menu Principal.-"
--       putStrLn "Opciones:"
--       putStrLn . unlines $ map concatIndice opciones
--       opcion <- getLine
--       case validar opcion of
--          Just n  -> ejecutar . read $ opcion
--          Nothing -> putStrLn "Pruebe otra vez."

--       menu
--    where concatIndice (i, (s, _)) = show i ++ ".) " ++ s

-- validar :: String -> Maybe Int
-- validar s = esValido (reads s)
--    where esValido []           = Nothing
--          esValido ((n, _):_) 
--                | sobrepasa   n = Nothing
--                | otherwise     = Just n
--          sobrepasa n = (n < 1) || (n > length opciones)

-- ejecutar :: Int -> IO ()
-- ejecutar n = ejecuta $ filter (\(i, _) -> i == n) opciones
--    where ejecuta ((_, (_,f)):_) = f

--funciones
-- elem :: (Eq a) => a -> [ a ] -> Bool
-- elem unElemento unaLista = any (unElemento==) unaLista

-- buscar :: (Eq a) => a -> [a] -> a
-- buscar nombre lista = map (==_nombre) clientes

-- buscar_en lista nombre = filter (==nombre) clientes

-- Usados en otra funcion

--pelicula_copias x = "Pelicula: " ++nombre_pelicula x++" | Copias: "++ show (cantidad_copias_pelicula x)
-- nombre_apellido x = _nombre (clientes !! x) ++ " " ++ _apellido (clientes!! x)

-- -- Usados como variables
-- cantidad_clientes = length clientes
-- --cantidad_copias_pelicula x = _copias (peliculas !! x)
-- nombre_pelicula x = _titulo (peliculas!! x)

-- -- Todas lasP.peliculas de un cliente
-- peliculas_cliente x = _alquileres (clientes!! x)


-- Se cuenta con los tipos compuestos: Videoclub, Cliente y Película, y las siguientes funciones:
-- •   y  1-Clientes, que devuelve una lista con los clientes registrados en el videoclub.
-- •   y  2-Películas, que devuelve una lista con las películas que están en el catálogo del videoclub, independientemente de si esta disponible o no.
-- •   y  3-CantidadDeCopiasPelicula, que devuelve cuantas copias de una película tiene el videoclub (esta función se indefine, o sea da error, si la película no pertenece al catalogo del videoclub).
-- •   y  4-CantidadDeCopias, que devuelve una lista con las películas y cuantas copias  tiene el videoclub.
-- •   y  5-PelículasNoAlquiladas, que devuelve una lista de películas que no han sido alquiladas.
-- •   y  6-peliculasPorCategoria, que devuelve un listado de películas por categoría seleccionada.*
-- •   y  7-PelículasAlquiladasPorCliente, que devuelve una lista de películas que el cliente tiene alquiladas en el videoclub (esta función se indefine si el cliente no esta registrado en el videoclub). El cliente puede alquilar más de una copia de la misma película.
-- •   y  8-Alquiló, que indica si un cliente de un videoclub alquiló una película en particular.
-- •      9-CopiasAlquiladas, que devuelve la cantidad de copias de la película dada que están alquiladas en un videoclub.
-- •   c  10-DisponibleParaAlquilar, que indica si una película esta disponible para ser alquilada en el videoclub (por ejemplo, una película puede estar en un videoclub pero no estar disponible porque todas sus copias están alquiladas, o no estar disponible porque no esta en el catálogo).
-- •   y  11-CategoriasDisponibles, que devuelve una lista de categorías disponibles en el videoclub.*

-- Especificar y definir las siguientes funciones:
-- 1.  y disponibleEnLaRed, que dice si la película está disponible en al menos alguno de los videoclubs de la red.
-- 2.  y masAlquiladaEnLaRed, que devuelve la película más alquilada en todos los videoclubs de la red.
-- 3.    ClientesRaros, que devuelve la lista de clientes que tienen alquilada la misma película en distintos videoclubs.
-- 4.  y CantidadTitulosOriginales, que devuelve una lista con las películas de todos los videoclubs, sin repetidos.
-- 5.  y peliculasDisponibles, que devuelve una lista con las películas disponibles, de entre los videoclubs de la red, para alquilar y el número de copias.
-- 6.  c peliculasDisponiblesPorCategoria, que devuelve una lista con las películas disponibles por categoría seleccionada,
--       de entre los videoclubs de la red, para alquilar y el número de copias.*
        --falta meter  en el menu y pasar los parametros

-- 7.  y CantidadDePeliculasPorCategoria, devuelve un listado de categorías con la cantidad de películas que hay dentro de esa clasificación.*
-- 8.  c BuscarPeli, devuelve un listado con los videoclubs que tienen una determinada película.*
        --falta meter  en el menu y pasar los parametros

-- Objetivos Adicionales de la práctica. Conseguir hacer funciones para añadir datos dinámicos como videoclubs, clientes y películas.
