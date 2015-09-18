import Data.List

-- data Identified a = Identified
--   { _id  :: Int
--   , _val :: a
--   } deriving (Functor, Show)

-- instance Comonad Identified where
--   extract = _val
--   duplicate v = Identified (_id v) v

data Cliente = Cliente
      { _idc        :: Int
      , _nombre     :: String
      , _apellido   :: String
      , _edad       :: Int
      , _alquileres :: [Pelicula]
      } deriving Show

data VideoClub = VideoClub
      { _idvc        :: Int
      , _nombre_vc   :: String
      , _direccion   :: String
      } deriving Show

data Categoria = Categoria
      { _id          :: Int
      , _tipo        :: String
      } deriving Show

data Pelicula = Pelicula
      { _idp         :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
      , _videoclub   :: VideoClub
      , _categoria   :: Categoria
      -- , _cliente     :: Clientew
      } deriving Show

-- data Alquiler = Alquiler
--       { _ida         :: Int
--       , _videoclub   :: VideoClub
--       , _cliente     :: Cliente
--       , _pelicula    :: Pelicula
--       } deriving Show

      -- Carga de datos
        
cliente1 = Cliente 1  "Howard"    "Lovecraft" 46 []
cliente2 = Cliente 2  "Charles"   "Ward"      26 []
cliente3 = Cliente 3  "Marinus"   "Willett"   56 [] 
cliente4 = Cliente 4  "William"   "Dyer"      53 [] 
cliente5 = Cliente 5  "Frank"     "Pabodie"   49 [] 
cliente6 = Cliente 6  "Herbert"   "West"      32 [] 
cliente7 = Cliente 7  "Abdul"     "Alhazred"  71 [] 
cliente8 = Cliente 8  "Alejandro" "Maier"     20 []
cliente9 = Cliente 9  "Amilcar"   "Rey"       20 []  
cliente10= Cliente 10 "Seba"      "Calderon"  20 [] 

videoclub1 = VideoClub 1 "VHS Movies"           "25 de mayo 333"  
videoclub2 = VideoClub 2 "All the movies 4 you" "9 de julio 128"  
videoclub3 = VideoClub 3 "Hollywood movies"     "Buenos Aires 24"                 


-- PARA MI ESTA MAL ACA LAS PELICULAS deberias ser como las categorias y clientes, definirlas y luego usarlas, me parece.. <--VER

--          |Tipo    |id |    titulo pelicula             | alquilada?| Videclub    |   categoria   |   cliente?  |
pelicula1  = Pelicula 1   "At the Mountains of Madness"       True      videoclub1      categoria1     
pelicula2  = Pelicula 2   "The Case of Charles Dexter Ward"   True      videoclub1      categoria1      
pelicula3  = Pelicula 3   "Herbert West -- The Re-animator"   True      videoclub1      categoria1      
pelicula4  = Pelicula 4   "The Call"                          True      videoclub1      categoria7      
pelicula5  = Pelicula 5   "Frozen"                            True      videoclub2      categoria5      
pelicula6  = Pelicula 6   "Fight Club"                        False     videoclub2      categoria4      
pelicula7  = Pelicula 7   "Frozen"                            False     videoclub2      categoria5      
pelicula8  = Pelicula 8   "At the Mountains of Madness"       False     videoclub2      categoria1      
pelicula9  = Pelicula 9   "The Call"                          False     videoclub3      categoria7      
pelicula10 = Pelicula 10  "Frozen"                            True      videoclub3      categoria1      
pelicula11 = Pelicula 11  "The Case of Charles Dexter Ward"   True      videoclub3      categoria1      
pelicula12 = Pelicula 12  "Herbert West -- The Re-animator"   True      videoclub3      categoria1      
pelicula13 = Pelicula 13  "The Call"                          True      videoclub2      categoria7      
pelicula14 = Pelicula 14  "Frozen"                            True      videoclub1      categoria5      

categoria1 = Categoria 1 "Ficción"
categoria2 = Categoria 2 "Drama"
categoria3 = Categoria 3 "Suspenso"
categoria4 = Categoria 4 "Acción"
categoria5 = Categoria 5 "Fantasía"
categoria6 = Categoria 6 "Comedia"
categoria7 = Categoria 7 "Miedo"

-- carga en listas

clientes   = [cliente1, cliente2, cliente3, cliente4, cliente5, cliente6, cliente7, cliente8, cliente9, cliente10]
peliculas  = [pelicula1, pelicula2, pelicula3, pelicula4, pelicula5, pelicula6, pelicula7, pelicula8, pelicula9, pelicula10, pelicula11, pelicula12, pelicula13, pelicula14]
videclubs  = [videoclub1,videoclub2,videoclub3]
categorias = [categoria1,categoria2,categoria3,categoria4,categoria5,categoria6,categoria7]

clientes2 = ["Ale","Juan","Amilcar","Ale","Ale"]

--  "Ale Maier" Peliculas Alquiladas: 3
-- listar_cliente_cant_pelis x = "Cliente: " ++nombre_apellido x ++ " | Peliculas Alquiladas: " ++ show (length (_alquileres (clientes!! x))) 

-- Listas 

listar_copias_peliculas = mapM_  print $map (copiasPelicula)    peliculas
listar_clientes         = mapM_  print $map (tellCliente)       clientes
listar_peliculas        = mapM_  print $map (tellPelicula)      peliculas
listar_peliculas_vc     = mapM_  print $map (videoclubPelicula) peliculas
listar_peliculas_na     = mapM_  print $map (peliculasNoAlquiladas) peliculas

peliculasNoAlquiladas :: Pelicula -> String
peliculasNoAlquiladas (Pelicula {_titulo=t,_alquilada=a}) = if a == False then "Pelicula: "++t else ""
--funciones
-- elem :: (Eq a) => a -> [ a ] -> Bool
-- elem unElemento unaLista = any (unElemento==) unaLista

--probando similar a las "funciones pro" de linea 112
listar thing = case thing of Cliente {_nombre = n, _apellido=a} -> n ++ " "++a
                            
listarClientes = mapM_ print $map (listar) clientes



--Funciones pro

tellCliente :: Cliente -> String
tellCliente (Cliente {_idc = i,_nombre = n, _apellido = a }) = "Cliente "++show i ++ ": " ++ a ++", "++ n

tellPelicula :: Pelicula -> String
tellPelicula (Pelicula {_idp = i, _titulo = t, _alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ " -> "++estadoPelicula a

tituloPelicula :: Pelicula -> String
tituloPelicula (Pelicula {_titulo = t}) = t 

copiasPelicula :: Pelicula -> String
copiasPelicula (Pelicula {_idp = i,_titulo = t}) = "Pelicula: "++ show i++ ": "++ t++ " | Cantidad de copias: "++ show(cantidad_copias t)

videoclubPelicula :: Pelicula -> String
videoclubPelicula (Pelicula {_titulo =t, _videoclub=v,_alquilada=a}) = "La pelicula: "
                                                                       ++t
                                                                       ++ "-> se encuentra en el videclub: "
                                                                       ++ _nombre_vc v 
                                                                       ++"-> El estado de la pelicula es: " 
                                                                       ++ estadoPelicula a


estadoPelicula estado = if estado == True then " Disponible" else " No disponible"

--
existe_pelicula titulo = find (==titulo) $map (tituloPelicula) peliculas
cantidad_copias titulo = length $filter (==titulo) $map (tituloPelicula) peliculas 


contar_pelicula titulo = case (existe_pelicula titulo) of Nothing     -> "No existe esa pelicula"
                                                          Just titulo -> titulo ++" tiene " ++ if (cantidad_copias titulo) == 1 
                                                            then show(cantidad_copias titulo)++" copia." 
                                                            else show (cantidad_copias titulo)++" copias."

                                                                                                                    
-- buscar :: (Eq a) => a -> [a] -> a
-- buscar nombre lista = map (==_nombre) clientes 

-- buscar_en lista nombre = filter (==nombre) clientes


-- Usados en otra funcion

--pelicula_copias x = "Pelicula: " ++nombre_pelicula x++" | Copias: "++ show (cantidad_copias_pelicula x)
nombre_apellido x = _nombre (clientes !! x) ++ " " ++ _apellido (clientes!! x)

-- Usados como variables
cantidad_clientes = length clientes
--cantidad_copias_pelicula x = _copias (peliculas !! x)
nombre_pelicula x = _titulo (peliculas!! x) 

-- Todas las peliculas de un cliente
peliculas_cliente x = _alquileres (clientes!! x)


-- Se cuenta con los tipos compuestos: Videoclub, Cliente y Película, y las siguientes funciones: 
-- •   y  Clientes, que devuelve una lista con los clientes registrados en el videoclub. 
-- •   y  Películas, que devuelve una lista con las películas que están en el catálogo del videoclub, independientemente de si esta disponible o no. 
-- •   y  CantidadDeCopiasPelicula, que devuelve cuantas copias de una película tiene el videoclub (esta función se indefine, o sea da error, si la película no pertenece al catalogo del videoclub). 
-- •   n  CantidadDeCopias, que devuelve una lista con las películas y cuantas copias  tiene el videoclub. 
-- •     PelículasNoAlquiladas, que devuelve una lista de películas que no han sido alquiladas.
-- •     PeliculasPorCategoria, que devuelve un listado de películas por categoría seleccionada.*
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
-- 5.    PeliculasDisponibles, que devuelve una lista con las películas disponibles, de entre los videoclubs de la red, para alquilar y el número de copias.
-- 6.    PeliculasDisponiblesPorCategoria, que devuelve una lista con las películas disponibles por categoría seleccionada, de entre los videoclubs de la red, para alquilar y el número de copias.*
-- 7.    CantidadDePeliculasPorCategoria, devuelve un listado de categorías con la cantidad de películas que hay dentro de esa clasificación.*
-- 8.    BuscarPeli, devuelve un listado con los videoclubs que tienen una determinada película.*

-- Objetivos Adicionales de la práctica. Conseguir hacer funciones para añadir datos dinámicos como videoclubs, clientes y películas.

-- main = do putStrLn "What is 2 + 2?"
--           x <- readLn
--           if x == 4
--               then putStrLn "You're right!"
--               else putStrLn "You're wrong!"
