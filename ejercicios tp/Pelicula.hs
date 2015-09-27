module Pelicula where
import Data.List

import qualified VideoClub as V
data Pelicula = Pelicula
      { _id          :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
      , _videoclub   :: V.VideoClub
      , _categoria   :: String
      } deriving Show
-- Ingreso de datos

-- main = do putStrLn "Titulo de la pelicula:"
--           titulo <- readLn
--           if titulo == " "
--               then putStrLn "Ingresa un titulo valido"
--               else putStrLn titulo



-- PARA MI ESTA MAL ACA LAS PELICULAS deberias ser como clientes, definirlas y luego usarlas, me parece.. <--VER

--          |Tipo    |id |    titulo pelicula             | alquilada?| Videclub    |   categoria   |   cliente?  |
pelicula1  = Pelicula 1   "At the Mountains of Madness"       True      V.videoclub1      "Ficcion"
pelicula2  = Pelicula 2   "The Case of Charles Dexter Ward"   True      V.videoclub1      "Ficcion"
pelicula3  = Pelicula 3   "Herbert West -- The Re-animator"   True      V.videoclub1      "Ficcion"
pelicula4  = Pelicula 4   "The Call"                          True      V.videoclub1      "Miedo"
pelicula5  = Pelicula 5   "Frozen"                            True      V.videoclub2      "Fantasia"
pelicula6  = Pelicula 6   "Fight Club"                        False     V.videoclub2      "Accion"
pelicula7  = Pelicula 7   "At the Mountains of Madness"       False     V.videoclub1      "Ficcion"
pelicula8  = Pelicula 8   "Frozen"                            False     V.videoclub1      "Fantasia"
pelicula9  = Pelicula 9   "The Call"                          False     V.videoclub2      "Miedo"

peliculas  = [pelicula1 , pelicula2, pelicula3, pelicula4, pelicula5, pelicula6, pelicula7, pelicula8,pelicula9]

tituloPeliculas :: Pelicula -> String
tituloPeliculas (Pelicula {_titulo = t}) = "Pelicula: "++t

tellPelicula :: Pelicula -> String
tellPelicula (Pelicula {_id = i, _titulo = t, _alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ " -> "++estadoPelicula a

tituloPelicula :: Pelicula -> String
tituloPelicula (Pelicula {_titulo = t}) = t

copiasPelicula :: Pelicula -> String
copiasPelicula (Pelicula {_id = i,_titulo = t}) = "Pelicula: "++ show i++ ": "++ t++ " | Cantidad de copias: "++ show(cantidad_copias t)

videoclubPelicula :: Pelicula -> String
videoclubPelicula (Pelicula {_titulo =t, _videoclub=v,_alquilada=a}) = "La pelicula: "
                                                                       ++t
                                                                       ++ "-> se encuentra en el videclub: "
                                                                       ++ V._nombre v
                                                                       ++"-> El estado de la pelicula es: "
                                                                       ++ estadoPelicula a
-- categorias = 

peliculas_na = filter (not . _alquilada) peliculas                                      --Devuelve una lista de peliculas que no estan alquiladas

peliculas_count = length peliculas -1                                                   --Devuelve el numero de peliculas que hay, como valor utilizable

estadoPelicula estado = if estado == False then " Disponible" else " No disponible"

existe_pelicula titulo = find (==titulo) $map (tituloPelicula) peliculas                --Devuelve un bool si existe la pelicula con ese titulo

cantidad_copias titulo = length $filter (==titulo) $map (tituloPelicula) peliculas      --Devuelve el numero de copias de una pelicula segun el titulo

contar_pelicula titulo = case (existe_pelicula titulo) of Nothing     -> "No existe esa pelicula"
                                                          Just titulo -> titulo ++" tiene " ++ if (cantidad_copias titulo) == 1
                                                            then show(cantidad_copias titulo)++" copia."
                                                            else show (cantidad_copias titulo)++" copias."

listar_copias_peliculas = mapM_  print $map (copiasPelicula)        peliculas
listar_peliculas        = mapM_  print $map (tellPelicula)          peliculas
listar_peliculas_vc     = mapM_  print $map (videoclubPelicula)     peliculas
listar_peliculas_na     = mapM_  print $map (tituloPeliculas)       peliculas_na
