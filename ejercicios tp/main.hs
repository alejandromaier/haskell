module Main where

import Data.List
import qualified VideoClub   as V
import qualified Cliente     as C
import qualified Pelicula    as P
import qualified Alquiler    as A
 
-- Listas 

listar_copias_peliculas = mapM_  print $map (copiasPelicula)    P.peliculas
listar_clientes         = mapM_  print $map (tellCliente)       C.clientes
listar_peliculas        = mapM_  print $map (tellPelicula)      P.peliculas
listar_peliculas_vc     = mapM_  print $map (videoclubPelicula) P.peliculas
listar_peliculas_na     = mapM_  print $map (peliculasNoAlquiladas) P.peliculas

peliculasNoAlquiladas :: P.Pelicula -> String
peliculasNoAlquiladas (P.Pelicula {P._titulo=t,P._alquilada=a}) = if a == False then "Pelicula: "++t else ""
--funciones
-- elem :: (Eq a) => a -> [ a ] -> Bool
-- elem unElemento unaLista = any (unElemento==) unaLista

--probando similar a las "funciones pro" de linea 112
-- listar thing = case thing of Cliente {_nombre = n, _apellido=a} -> n ++ " "++a
                            
-- listarClientes = mapM_ print $map (listar) Cliente.clientes



--Funciones pro

tellCliente :: C.Cliente -> String
tellCliente (C.Cliente {C._id = i,C._nombre = n, C._apellido = a }) = "Cliente "++show i ++ ": " ++ a ++", "++ n

tellPelicula :: P.Pelicula -> String
tellPelicula (P.Pelicula {P._id = i, P._titulo = t, P._alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ " -> "++estadoPelicula a

tituloPelicula :: P.Pelicula -> String
tituloPelicula (P.Pelicula {P._titulo = t}) = t 

copiasPelicula :: P.Pelicula -> String
copiasPelicula (P.Pelicula {P._id = i,P._titulo = t}) = "Pelicula: "++ show i++ ": "++ t++ " | Cantidad de copias: "++ show(cantidad_copias t)

videoclubPelicula :: P.Pelicula -> String
videoclubPelicula (P.Pelicula {P._titulo =t, P._videoclub=v,P._alquilada=a}) = "La pelicula: "
                                                                       ++t
                                                                       ++ "-> se encuentra en el videclub: "
                                                                       ++ V._nombre v 
                                                                       ++"-> El estado de la pelicula es: " 
                                                                       ++ estadoPelicula a


estadoPelicula estado = if estado == True then " Disponible" else " No disponible"

--
existe_pelicula titulo = find (==titulo) $map (tituloPelicula) P.peliculas
cantidad_copias titulo = length $filter (==titulo) $map (tituloPelicula) P.peliculas 


contar_pelicula titulo = case (existe_pelicula titulo) of Nothing     -> "No existe esa pelicula"
                                                          Just titulo -> titulo ++" tiene " ++ if (cantidad_copias titulo) == 1 
                                                            then show(cantidad_copias titulo)++" copia." 
                                                            else show (cantidad_copias titulo)++" copias."

                                                                                                                    
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
-- •   y  Clientes, que devuelve una lista con los clientes registrados en el videoclub. 
-- •   y  Películas, que devuelve una lista con las películas que están en el catálogo del videoclub, independientemente de si esta disponible o no. 
-- •   y  CantidadDeCopiasPelicula, que devuelve cuantas copias de una película tiene el videoclub (esta función se indefine, o sea da error, si la película no pertenece al catalogo del videoclub). 
-- •   n  CantidadDeCopias, que devuelve una lista con las películas y cuantas copias  tiene el videoclub. 
-- •     PelículasNoAlquiladas, que devuelve una lista de películas que no han sido alquiladas.
-- •     peliculasPorCategoria, que devuelve un listado de películas por categoría seleccionada.*
-- •     PelículasAlquiladasPorCliente, que devuelve una lista de películas que el cliente tiene alquiladas en el videoclub (esta función se indefine si el cliente no esta registrado en el videoclub). El cliente puede alquilar más de una copia de la misma película. 
-- •     Alquiló, que indica si un cliente de un videoclub alquiló una película en particular. 
-- •     CopiasAlquiladas, que devuelve la cantidad de copias de la película dada que están alquiladas en un videoclub. 
-- •     DisponibleParaAlquilar, que indica si una película esta disponible para ser alquilada en el videoclub (por ejemplo, una película puede estar en un videoclub pero no estar disponible porque todas sus copias están alquiladas, o no estar disponible porque no esta en el catálogo). 
-- •     CategoriasDisponibles, que devuelve una lista de categorías disponibles en el videoclub.*

-- Especificar y definir las siguientes funciones:
-- 1.    disponibleEnLaRed, que dice si la película está disponible en al menos alguno de los videoclubs de la red.
-- 2.    masAlquiladaEnLaRed, que devuelve la película más alquilada en todos los videoclubs de la red. 
-- 3.    ClientesRaros, que devuelve la lista de clientes que tienen alquilada la misma película en distintos videoclubs.
-- 4.    CantidadTitulosOriginales, que devuelve una lista con las películas de todos los videoclubs, sin repetidos.
-- 5.    peliculasDisponibles, que devuelve una lista con las películas disponibles, de entre los videoclubs de la red, para alquilar y el número de copias.
-- 6.    peliculasDisponiblesPorCategoria, que devuelve una lista con las películas disponibles por categoría seleccionada, de entre los videoclubs de la red, para alquilar y el número de copias.*
-- 7.    CantidadDePeliculasPorCategoria, devuelve un listado de categorías con la cantidad de películas que hay dentro de esa clasificación.*
-- 8.    BuscarPeli, devuelve un listado con los videoclubs que tienen una determinada película.*

-- Objetivos Adicionales de la práctica. Conseguir hacer funciones para añadir datos dinámicos como videoclubs, clientes y películas.

-- main = do putStrLn "What is 2 + 2?"
--           x <- readLn
--           if x == 4
--               then putStrLn "You're right!"
--               else putStrLn "You're wrong!"
