import Data.List

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
      , _clientes    :: [Cliente]
      , _peliculas   :: [Pelicula]
      } deriving Show

data Categoria = Categoria
      { _id          :: Int
      , _tipo        :: String
      }

data Pelicula = Pelicula
      { _idp         :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
      -- , _videoclub   :: VideoClub
      } deriving Show

data Alquiler = Alquiler
      { _ida         :: Int
      , _id_video_club  :: VideoClub
      , _cliente     :: Cliente
      , _pelicula    :: Pelicula
      } deriving Show
        
cliente1 = Cliente 1  "Howard"    "Lovecraft" 46 [pelicula1, pelicula2]
cliente2 = Cliente 2  "Charles"   "Ward"      26 [pelicula2]
cliente3 = Cliente 3  "Marinus"   "Willett"   56 [pelicula3, pelicula4]
cliente4 = Cliente 4  "William"   "Dyer"      53 [pelicula4, pelicula1]
cliente5 = Cliente 5  "Frank"     "Pabodie"   49 []
cliente6 = Cliente 6  "Herbert"   "West"      32 [pelicula4, pelicula1, pelicula2]
cliente7 = Cliente 7  "Abdul"     "Alhazred"  71 [pelicula3]
cliente8 = Cliente 8  "Alejandro" "Maier"     20 [pelicula5,pelicula3,pelicula2,pelicula1]
cliente9 = Cliente 9  "Amilcar"   "Rey"       20 [pelicula1]
cliente10= Cliente 10 "Seba"      "Calderon"  20 [pelicula5,pelicula4]

pelicula1 = Pelicula 1 "At the Mountains of Madness"       True  
pelicula2 = Pelicula 2 "The Case of Charles Dexter Ward"   True 
pelicula3 = Pelicula 3 "Herbert West -- The Re-animator"   True 
pelicula4 = Pelicula 4 "The Call"                          True  
pelicula5 = Pelicula 5 "Frozen"                            True
pelicula6 = Pelicula 6 "Fight Club"                        False
pelicula7 = Pelicula 7 "Frozen"                            False
pelicula8 = Pelicula 8 "At the Mountains of Madness"       False
pelicula9 = Pelicula 9 "The Call"                          False

clientes = [cliente1, cliente2, cliente3, cliente4, cliente5, cliente6, cliente7, cliente8, cliente9, cliente10]
peliculas   = [pelicula1, pelicula2, pelicula3, pelicula4, pelicula5, pelicula6, pelicula7, pelicula8, pelicula9]
clientes2 = ["Ale","Juan","Amilcar","Ale","Ale"]
--  "Ale Maier" Peliculas Alquiladas: 3
listar_cliente_cant_pelis x = "Cliente: " ++nombre_apellido x ++ " | Peliculas Alquiladas: " ++ show (length (_alquileres (clientes!! x))) 

-- Listas 
-- listar_peliculas = mapM_ print peliculas
-- listar_clientes = mapM_ print clientes
--funciones
elem :: (Eq a) => a -> [ a ] -> Bool
elem unElemento unaLista = any (unElemento==) unaLista
--listar_peliculas_copias = 

--Funciones pro

tellCliente :: Cliente -> String
tellCliente (Cliente {_idc = i,_nombre = n, _apellido = a }) = "Cliente "++show i ++ ": " ++ a ++", "++ n

tellPelicula :: Pelicula -> String
tellPelicula (Pelicula {_idp = i, _titulo = t, _alquilada=a}) = "Pelicula "++ show i ++ ": " ++ t ++ (if a == True then "| Disponible" else "| No disponible")

tituloPelicula :: Pelicula -> String
tituloPelicula (Pelicula {_titulo = t}) = t 

copiasPelicula :: Pelicula -> String
copiasPelicula (Pelicula {_idp = i,_titulo = t}) = "Pelicula: "++ show i ++ ": " ++ t ++ " | Cantidad de copias: "++ show(cantidad_copias t)




-- cantidad_copias_pelicula :: String -> int
-- cantidad_copias_pelicula titulo = length (filter )
existe_pelicula titulo = find (==titulo) $map (tituloPelicula) peliculas
cantidad_copias titulo = length $filter (==titulo) $map (tituloPelicula) peliculas 

contar_pelicula titulo = case (existe_pelicula titulo) of Nothing     -> "No existe esa pelicula"
                                                          Just titulo -> titulo ++" tiene " ++ if (cantidad_copias titulo) == 1 then show(cantidad_copias titulo)++" copia." else show (cantidad_copias titulo)++" copias."

                                                                                                                                     
listar_copias_peliculas = mapM print $map (copiasPelicula) peliculas
listar_clientes = mapM_ print $map (tellCliente) clientes
listar_peliculas = mapM_ print $map (tellPelicula) peliculas


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

