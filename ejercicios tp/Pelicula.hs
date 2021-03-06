module Pelicula where
import Data.List
import System.IO
import System.Process
-- import AnsiScreen
import qualified Data.Map as Map
import qualified Data.Set as Set

data Pelicula = Pelicula
      { _id          :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
      , _categoria   :: String
      } deriving (Eq,Show,Ord)




--          |Tipo    |id |    titulo pelicula             | alquilada?|    |   categoria
pelicula1  = Pelicula 1   "Inception"                         True            "Ficcion"
pelicula2  = Pelicula 2   "Inception"                         True            "Ficcion"
pelicula3  = Pelicula 3   "Inception"                         True             "Ficcion"
pelicula4  = Pelicula 4   "The Call"                          True             "Miedo"
pelicula5  = Pelicula 5   "Frozen"                            True             "Fantasia"
pelicula6  = Pelicula 6   "Fight Club"                        True             "Accion"
pelicula7  = Pelicula 7   "Now you see me"                    True             "Suspenso"
pelicula8  = Pelicula 8   "Frozen"                            True             "Fantasia"
pelicula9  = Pelicula 9   "The Call"                          True             "Miedo"
pelicula10 = Pelicula 10  "Up"                                True             "Fantasia"
pelicula11 = Pelicula 11  "Safe House"                        False            "Suspenso"
pelicula12 = Pelicula 12  "Transformers 1"                    False            "Accion"
pelicula13 = Pelicula 13  "Transformers 2"                    False            "Accion"
pelicula14 = Pelicula 14  "Transformers "                     True             "Accion"
pelicula15 = Pelicula 15   "Inception"                        True             "Ficcion"
pelicula16 = Pelicula 16   "Inception"                        False            "Ficcion"
pelicula17 = Pelicula 17  "Transformers 1"                    False            "Accion"

flag       = Pelicula 0 "" True ""

peliculas  = [pelicula1 , pelicula2, pelicula3, pelicula4, pelicula5, pelicula6, pelicula7, pelicula8,pelicula9, pelicula10,pelicula11,pelicula12,pelicula13,pelicula14, pelicula15, pelicula16,pelicula17]



agruparPorCat :: Pelicula -> Pelicula -> Bool
agruparPorCat t1 t2 = _categoria t1 == _categoria t2





-- *********************************************************
--masAlquiladaEnLaRed, que devuelve la película más alquilada en todos los videoclubs de la red.
-- *********************************************************

agruparPorTitulo :: Pelicula -> Pelicula -> Bool
agruparPorTitulo t1 t2 = _titulo t1 == _titulo t2

--sortByTitle = $groupBy P.agruparPorTitulo $ sortBy (\x y -> P._titulo x `compare` P._titulo y) P.peliculas


masAlquiladaEnLaRed = tituloPelicula $head (last (sortBy (\x y -> (length x) `compare` (length y)) $groupBy agruparPorTitulo $ sortBy (\x y -> _titulo x `compare` _titulo y) peliculas_alquiladas))

peliculas_alquiladas = [ p | p <- peliculas, p_na <- peliculas_na,  p /= p_na] 






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


tituloPelicula :: Pelicula -> String
tituloPelicula (Pelicula {_titulo = t}) = t










cateoriaPelicula :: Pelicula -> String
cateoriaPelicula (Pelicula {_categoria = c}) = c




--listaDePeliculasPorCategoria :: String -> [Pelicula]
 --listaDePeliculasPorCategoria categoria = [x | x <- peliculas, c <- categoria, (cateoriaPelicula x) `elem` c ]



peliculas_categoria ctg =  [(_titulo x) ++ ", copias "++show (cantidad_copias_peliculas peliculas_na (_titulo x)) | x <- peliculas_na, cateoriaPelicula x == ctg]


peliculasDisponiblesCategoria :: IO ()
peliculasDisponiblesCategoria = do listar_categorias_indices peliculas
                                   p <- readLn
                                   let ctg = (categorias_ordenadas peliculas) !! pred p
                                   mapM_ print $nub (peliculas_categoria ctg)

-- ******FUNCIONA!*******
--let x = [x | x <- P.peliculas, cat <- "Ficcion", P.cateoriaPelicula x == "Ficcion" ]
--or
--let x ctg = [ x | x <- P.peliculas_na, P.cateoriaPelicula x == ctg]

--nub x








------ Se usa en el punto 4)

copiasPeliculas :: [Pelicula] -> Pelicula -> String
copiasPeliculas p (Pelicula {_id = i,_titulo = t}) = t++ " | Cantidad de copias: "++ show(cantidad_copias_peliculas p t)

cantidad_copias_peliculas p t =length $filter (==t) $map (tituloPelicula) p

------




tellPelicula :: Pelicula -> String
tellPelicula (Pelicula {_id = i, _titulo = t, _alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ " -> "++estadoPelicula a

peliculaIndice :: Pelicula -> String
peliculaIndice (Pelicula {_id = i, _titulo = t}) = "Pelicula "++ show i ++ ": " ++ t


copiasPelicula :: Pelicula -> String
copiasPelicula (Pelicula {_id = i,_titulo = t}) = "Pelicula: "++ show i++ ": "++ t++ " | Cantidad de copias: "++ show(cantidad_copias t)

estadoPeliculas :: Pelicula -> String
estadoPeliculas (Pelicula {_titulo =t, _alquilada=a}) = "La pelicula: " ++t++ "-> El estado de la pelicula es: " ++ estadoPelicula a

peliculaDatos :: Pelicula -> String
peliculaDatos (Pelicula{_titulo=t,_alquilada=a,_categoria=c}) = "Pelicula: "++ t ++ " se encuentra "++estadoPelicula a ++ ", pertenece a la categoria: "++ c



agrupar_peliculas_categoria p = groupBy agruparPorCat $ sortBy (\x y -> _categoria x `compare` _categoria y) p


-- **************** --
--    categorias    --
-- **************** --

nombreCategoria :: Pelicula -> String
nombreCategoria (Pelicula {_categoria = t}) = t

-- agrupar_peliculas_videoclub = groupBy agruparPorVC $ sortBy (\x y -> _videoclub x `compare` _videoclub y) peliculas --peliculas en videoclub
categorias_indices p = zip [1..] $categorias_ordenadas p

--Lista en orden -> (1,"Accion") (2,"Fantasia") ..etc
categorias p = peliculaCategorias p

--Ordena las categorias existentes de la a-z
categorias_ordenadas x = sortBy (\x y -> x `compare` y )$peliculaCategorias x

--Cantidad de categorias
categorias_count = length (categorias peliculas) -1

--peliculasPorCategoria :: [String] -> Int Cuantas peliculas tiene una categoria
peliculasPorCategoria categoria = length $filter (==categoria) $map (nombreCategoria) peliculas

--esdecategoria categoria = if()

--peliculasdecategoria categoria = $filter (_categoria == categoria) peliculas

cantidadDePeliculasPorCategoria = map (peliculasPorCategoria) $categorias peliculas

cantPelisCategoria = mapM_ print mostrarCategoriasCantPeliculas

listado_a_medias :: [(String,Int)]
listado_a_medias = zip (categorias peliculas) cantidadDePeliculasPorCategoria

cat (s, i) = s ++ " - Cantidad de peliculas: " ++ show i

--mostrarCategoriasCantPeliculas = map cat listado_a_medias 

mostrarCategoriasCantPeliculas = [fst (x) ++ " tiene " ++ show (snd ( x)) ++ " peliculas." |x <- listado_a_medias]











-- **************** --
--   **Generales**  --
-- **************** --

--Devuelve el numero de peliculas que hay, como valor utilizable
peliculas_count = length peliculas -1                                                   

--Devuelve el numero de copias de una pelicula segun el titulo
cantidad_copias titulo = length $filter (==titulo) $map (tituloPelicula) peliculas      

cantidad_copias_na titulo = length $filter (==titulo) $map (tituloPelicula) peliculas_na      




-- **************** --
-- **Disponibilidad**
-- **************** --
--disponibleEnLaRed, que dice si la película está disponible en al menos alguno de los videoclubs de la red.
--Devuelve una lista de peliculas que no estan alquiladas
peliculas_na = filter (not . _alquilada) peliculas  

--Devuelve una lista de peliculas no alquiladas de un videoclub
peliculas_na_vc videoclub =  filter (not . _alquilada) videoclub

--Esta alquilada o no la peli? 
estadoPelicula estado = if estado == False then " Disponible" else " No disponible"

disponibles_cantidad = map (cantidad_copias_na) peliculas_naSinRepetir

peliculasDisponibles = zip peliculas_naSinRepetir disponibles_cantidad

contame_cual  = [ fst x ++ " esta disponible. Copias: " ++ show (snd x) | x <- peliculasDisponibles]

te_cuento_cual = mapM_ print $contame_cual 




-- **************** --
--  **Existencia**
-- **************** --
--Devuelve un bool si existe la pelicula con ese titulo
existe_pelicula titulo = find (==titulo) $map (tituloPelicula) peliculas                



--Recibe un string por parametro verifica si existe en la lista de peliculas, si existe muestra cuantas copias tiene.

contar_pelicula titulo = case (existe_pelicula titulo) of Nothing     -> "No existe esa pelicula"
                                                          Just titulo -> titulo ++" tiene " ++ if (cantidad_copias titulo) == 1
                                                            then show(cantidad_copias titulo)++" copia."
                                                            else show (cantidad_copias titulo)++" copias."


--Devuelve un bool si existe la pelicula con ese titulo y esta disponible
existe_pelicula_na titulo = find (==titulo) $map (tituloPelicula) peliculas_na                

--dice bien las cosas
tell_existe_pelicula_na titulo = case (existe_pelicula_na titulo) of Nothing     -> "No existe esa pelicula"
                                                                     Just titulo -> "Esta pelicula esta disponible en el catalogo de nuestra red" 


-- **************** --
--  **Sin repetir**
-- **************** --
--en forma ordenada las peliculas sin repetir
titulosOriginales = mapM_ print peliculasSinRepetir2

--Esto lista solo los titulos
peliculasSinRepetir = nub $map (tituloPelicula) peliculas

--Esto lista de forma Titulo: nombre
peliculasSinRepetir2 = nub $map (tituloPeliculas) peliculas

--Sin repetir las peliculas no alquiladas
peliculas_naSinRepetir = nub $map (tituloPelicula) peliculas_na












-- peliculas_por_vc x = map (tellPelicula) $(agrupar_peliculas_videoclub )!! x -- peliculas en videoclub
-- listar_categorias       = mapM_  print $peliculaCategorias          peliculas
listar_copias_peliculas = mapM_  print $map (copiasPelicula)        peliculas

peliculas_por_categoria x p = mapM_ print $nub . map (tituloPelicula) $(agrupar_peliculas_categoria p) !! x

listar_categorias_indices p= mapM_ print $categorias_indices p
listar_categorias       = mapM_  print $categorias_ordenadas         peliculas
listar_categorias_p p       = mapM_  print $categorias_ordenadas         p
-- listar_copias_peliculas = mapM_  print $map (copiasPelicula)        peliculas --arreglar que tenga en cuenta el videoclub

zipeando :: [String] -> [(Integer,(String))]
zipeando = zip [1..] 

concatIndice (i, (s)) = show i ++ ".) " ++ s


listar_peliculas        = mapM_  print $map (tellPelicula)          peliculas
listar_peliculas_vc     = mapM_  print $map (estadoPeliculas)       peliculas
listar_peliculas_na     = mapM_  print $map (tituloPeliculas)       peliculas_na
listar_peliculas_indice = mapM_  print $map concatIndice $zipeando $peliculaNombre peliculas
listar_peliculas_pro    = mapM_  print $map concatIndice $zipeando $map _titulo peliculas 

validar :: [Pelicula] -> String -> Maybe Int
validar p s = esValido (reads s)
   where esValido []           = Nothing
         esValido ((n, _):_) 
               | sobrepasa   n = Nothing
               | otherwise     = Just n
         sobrepasa n = (n < 0) || (n > length (categorias p))

listarPeliculasPorCategoria :: [Pelicula] -> IO ()
listarPeliculasPorCategoria p = do listar_categorias_indices p
                                   putStrLn "Ingrese el numero de una categoria: "
                                   putStrLn "Presione 0 (cero) para salir."
                                   x <- getLine
                                   case (validar p x) of 
                                      Just n  -> if n == 0 then undefined else  peliculas_por_categoria (pred n) p
                                      Nothing -> putStrLn "Pruebe otra vez."              
                                   listarPeliculasPorCategoria peliculas

cargarPelicula :: [Pelicula] -> IO [Pelicula]
cargarPelicula peliculas = 
  do putStrLn "Carga de peliculas: " 
     putStrLn "Titulo:"
     titulo <- getLine
     putStrLn "Categoria: "
     cat <- getLine
     let pelicula = Pelicula (length peliculas + 1) titulo False cat
     let pelis' = peliculas ++ [pelicula]
     return pelis'

listarPeliculas p = mapM_ print $map (peliculaDatos) p

opciones :: [(Int,(String))]
opciones = zip [1..] [("Cargar Pelicula"),("Listar peliculas por categoria"),("Listar Peliculas"),("Salir")]

menu :: [Pelicula] -> IO [Pelicula]
menu peliculas = do
  putStrLn "Eliga su opcion: "
  putStrLn . unlines $ map concatIndice opciones
  str <- getLine
  case read str of
    1 -> do peliculas' <- cargarPelicula peliculas             
            menu peliculas'
    2 -> putStrLn "Categorias: " >> listarPeliculasPorCategoria peliculas >> menu peliculas 
    3 -> listarPeliculas peliculas >> menu peliculas
    4 -> undefined
    _ -> putStrLn "Pruebe otra vez." >> menu peliculas

devuelvePelicula :: IO Pelicula
devuelvePelicula = do putStrLn "Peliculas: "                       
                      listar_peliculas_pro
                      putStrLn "Ingrese el numero de una pelicula: "
                      x <- readLn
                      let pelicula = peliculas !! pred x
                      return pelicula

devuelvePelicula2 :: IO String
devuelvePelicula2 = do putStrLn "Peliculas: "                       
                       listar_peliculas_indice
                       putStrLn "Ingrese el numero de una pelicula: "
                       x <- readLn
                       let pelicula = (peliculaNombre peliculas) !! pred x
                       return pelicula