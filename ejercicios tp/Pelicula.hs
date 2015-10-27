module Pelicula where
import Data.List
import System.IO
import System.Process
import qualified Data.Map as Map
import qualified Data.Set as Set

data Pelicula = Pelicula
      { _id          :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
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
pelicula1  = Pelicula 1   "Inception"                         False            "Ficcion"
pelicula2  = Pelicula 2   "Inception"                         False            "Ficcion"
pelicula3  = Pelicula 3   "Inception"                         True            "Ficcion"
pelicula4  = Pelicula 4   "The Call"                          True            "Miedo"
pelicula5  = Pelicula 5   "Frozen"                            True            "Fantasia"
pelicula6  = Pelicula 6   "Fight Club"                        True            "Accion"
pelicula7  = Pelicula 7   "Now you see me"                    True            "Suspenso"
pelicula8  = Pelicula 8   "Frozen"                            True            "Fantasia"
pelicula9  = Pelicula 9   "The Call"                          True            "Miedo"
pelicula10 = Pelicula 10  "Up"                                True            "Fantasia"
pelicula11 = Pelicula 11  "Safe House"                        False           "Suspenso"
pelicula12 = Pelicula 12  "Transformers 1"                    False           "Accion"
pelicula13 = Pelicula 13  "Transformers 2"                    False           "Accion"
pelicula14 = Pelicula 14  "Transformers "                     False           "Accion"

peliculas  = [pelicula1 , pelicula2, pelicula3, pelicula4, pelicula5, pelicula6, pelicula7, pelicula8,pelicula9,pelicula10,pelicula11,pelicula12,pelicula13,pelicula14]



agruparPorCat :: Pelicula -> Pelicula -> Bool
agruparPorCat t1 t2 = _categoria t1 == _categoria t2

-- agruparPorVC :: Pelicula -> Pelicula -> Bool
-- agruparPorVC t1 t2 = _videoclub t1 == _videoclub t2 -- peliculas en videoclub

groupToMap :: (Ord b) => (a -> b) -> [a] -> Map.Map b [a]
groupToMap toKey = Map.fromListWith (++) . map (\a -> (toKey a, [a]))

-- groupPeliculas ::  [Pelicula] -> Map.Map String [Pelicula]
-- groupPeliculas = groupToMap _categoria

-- peliculasCategorias :: [Pelicula] -> [String]
-- peliculasCategorias = map _categoria

-- peliculaCategories :: [Pelicula] -> Set.Set String
-- peliculaCategories = foldr Set.insert Set.empty . map _categoria

peliculaCategorias :: [Pelicula] -> [String]
peliculaCategorias = nub . map _categoria

peliculaNombre :: [Pelicula] -> [String]
peliculaNombre = nub . map _titulo

tituloPeliculas :: Pelicula -> String
tituloPeliculas (Pelicula {_titulo = t}) = "Titulo: "++t

tellPelicula :: Pelicula -> String
tellPelicula (Pelicula {_id = i, _titulo = t, _alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ " -> "++estadoPelicula a

tituloPelicula :: Pelicula -> String
tituloPelicula (Pelicula {_titulo = t}) = t

copiasPelicula :: Pelicula -> String
copiasPelicula (Pelicula {_id = i,_titulo = t}) = "Pelicula: "++ show i++ ": "++ t++ " | Cantidad de copias: "++ show(cantidad_copias t)

estadoPeliculas :: Pelicula -> String
estadoPeliculas (Pelicula {_titulo =t, _alquilada=a}) = "La pelicula: " ++t
                                                                       ++ "-> El estado de la pelicula es: " ++ estadoPelicula a


agrupar_peliculas_categoria = groupBy agruparPorCat $ sortBy (\x y -> _categoria x `compare` _categoria y) peliculas
-- agrupar_peliculas_videoclub = groupBy agruparPorVC $ sortBy (\x y -> _videoclub x `compare` _videoclub y) peliculas --peliculas en videoclub

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

-- peliculas_por_vc x = map (tellPelicula) $(agrupar_peliculas_videoclub )!! x -- peliculas en videoclub
-- listar_categorias       = mapM_  print $peliculaCategorias          peliculas
listar_copias_peliculas = mapM_  print $map (copiasPelicula)        peliculas

peliculas_por_categoria x = mapM_ print $nub . map (tituloPelicula) $agrupar_peliculas_categoria !! x

listar_categorias_indices= mapM_ print categorias_indices
listar_categorias       = mapM_  print $categorias_ordenadas         peliculas
-- listar_copias_peliculas = mapM_  print $map (copiasPelicula)        peliculas --arreglar que tenga en cuenta el videoclub

zipeando :: [String] -> [(Integer,(String))]
zipeando = zip [1..] 

concatIndice (i, (s)) = show i ++ ".) " ++ s


listar_peliculas        = mapM_  print $map (tellPelicula)          peliculas
listar_peliculas_vc     = mapM_  print $map (estadoPeliculas)       peliculas
listar_peliculas_na     = mapM_  print $map (tituloPeliculas)       peliculas_na
listar_peliculas_indice = mapM_ print  $map concatIndice $zipeando $peliculaNombre peliculas

menu :: IO ()
menu = do listar_categorias_indices
          putStrLn "Ingrese el numero de una categoria: "
          x <- readLn
          peliculas_por_categoria $ pred x


