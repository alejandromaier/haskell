module Pelicula where
import Data.List
import qualified Data.Map as Map
import qualified Data.Set as Set
import System.IO
import System.Process

import qualified VideoClub as V
data Pelicula = Pelicula
      { _id          :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
      , _videoclub   :: V.VideoClub
      , _categoria   :: String
      } deriving (Eq,Show,Ord)
-- Ingreso de datos

-- main = do putStrLn "Titulo de la pelicula:"
--           titulo <- readLn
--           if titulo == " "
--               then putStrLn "Ingresa un titulo valido"
--               else putStrLn titulo



-- PARA MI ESTA MAL ACA LAS PELICULAS deberias ser como clientes, definirlas y luego usarlas, me parece.. <--VER

--          |Tipo    |id |    titulo pelicula             | alquilada?| Videclub    |   categoria
pelicula1  = Pelicula 1   "Inception"                         True      V.videoclub1      "Ficcion"
pelicula2  = Pelicula 2   "Inception"                         False     V.videoclub2      "Ficcion"
pelicula3  = Pelicula 3   "Inception"                         True      V.videoclub1      "Ficcion"
pelicula4  = Pelicula 4   "The Call"                          False     V.videoclub1      "Miedo"
pelicula5  = Pelicula 5   "Frozen"                            True      V.videoclub2      "Fantasia"
pelicula6  = Pelicula 6   "Fight Club"                        False     V.videoclub2      "Accion"
pelicula7  = Pelicula 7   "Now you see me"                    False     V.videoclub1      "Suspenso"
pelicula8  = Pelicula 8   "Frozen"                            False     V.videoclub1      "Fantasia"
pelicula9  = Pelicula 9   "The Call"                          True      V.videoclub2      "Miedo"
pelicula10 = Pelicula 10  "Up"                                True      V.videoclub2      "Fantasia"

peliculas  = [pelicula1 , pelicula2, pelicula3, pelicula4, pelicula5, pelicula6, pelicula7, pelicula8,pelicula9,pelicula10]

groupFunction :: Pelicula -> Pelicula -> Bool
groupFunction t1 t2 = _categoria t1 == _categoria t2

groupToMap :: (Ord b) => (a -> b) -> [a] -> Map.Map b [a]
groupToMap toKey = Map.fromListWith (++) . map (\a -> (toKey a, [a]))

groupPeliculas ::  [Pelicula] -> Map.Map String [Pelicula]
groupPeliculas = groupToMap _categoria

-- peliculasCategorias :: [Pelicula] -> [String]
-- peliculasCategorias = map _categoria

-- peliculaCategories :: [Pelicula] -> Set.Set String
-- peliculaCategories = foldr Set.insert Set.empty . map _categoria

peliculaCategorias :: [Pelicula] -> [String]
peliculaCategorias = nub . map _categoria

tituloPeliculas :: Pelicula -> String
tituloPeliculas (Pelicula {_titulo = t}) = "Titulo: "++t

tellPelicula :: Pelicula -> String
tellPelicula (Pelicula {_id = i, _titulo = t, _alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ " -> "++estadoPelicula a

tituloPelicula :: Pelicula -> String
tituloPelicula (Pelicula {_titulo = t}) = t

copiasPelicula :: Pelicula -> String
copiasPelicula (Pelicula {_id = i,_titulo = t}) = "Pelicula: "++ show i++ ": "++ t++ " | Cantidad de copias: "++ show(cantidad_copias t)

videoclubPelicula :: Pelicula -> String
videoclubPelicula (Pelicula {_titulo =t, _videoclub=v,_alquilada=a}) = "La pelicula: " ++t
                                                                       ++ "-> se encuentra en el videclub: "
                                                                       ++ V._nombre v ++"-> El estado de la pelicula es: " ++ estadoPelicula a

-- iterarCategorias x = succ x until (x+1 == (length categorias))

agrupar_peliculas_categoria = groupBy groupFunction $ sortBy (\x y -> _categoria x `compare` _categoria y) peliculas

categorias_indices = zip [1..(categorias_count)] $categorias_ordenadas peliculas  --Lista en orden -> (1,"Accion") (2,"Fantasia") ..etc
 
categorias = peliculaCategorias peliculas 

categorias_ordenadas x = sortBy (\x y -> x `compare` y )$peliculaCategorias x

peliculas_na = filter (not . _alquilada) peliculas                                      --Devuelve una lista de peliculas que no estan alquiladas

peliculas_count = length peliculas -1                                                   --Devuelve el numero de peliculas que hay, como valor utilizable

categorias_count = length categorias -1

estadoPelicula estado = if estado == False then " Disponible" else " No disponible"

existe_pelicula titulo = find (==titulo) $map (tituloPelicula) peliculas                --Devuelve un bool si existe la pelicula con ese titulo

cantidad_copias titulo = length $filter (==titulo) $map (tituloPelicula) peliculas      --Devuelve el numero de copias de una pelicula segun el titulo

contar_pelicula titulo = case (existe_pelicula titulo) of Nothing     -> "No existe esa pelicula"
                                                          Just titulo -> titulo ++" tiene " ++ if (cantidad_copias titulo) == 1
                                                            then show(cantidad_copias titulo)++" copia."
                                                            else show (cantidad_copias titulo)++" copias."

peliculas_por_categoria x = mapM_ print $nub . map (tituloPelicula) $agrupar_peliculas_categoria !! x

listar_categorias_indices= mapM_ print categorias_indices
listar_categorias       = mapM_  print $categorias_ordenadas         peliculas
-- listar_copias_peliculas = mapM_  print $map (copiasPelicula)        peliculas --arreglar que tenga en cuenta el videoclub
listar_peliculas        = mapM_  print $map (tellPelicula)          peliculas
listar_peliculas_vc     = mapM_  print $map (videoclubPelicula)     peliculas
listar_peliculas_na     = mapM_  print $map (tituloPeliculas)       peliculas_na



main = do listar_categorias_indices
          putStrLn "Ingrese el numero de una categoria: "
          x <- readLn 
          peliculas_por_categoria $ pred x
