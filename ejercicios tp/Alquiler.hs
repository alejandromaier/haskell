module Alquiler where
import qualified VideoClub as V
import qualified Cliente as C
import qualified Pelicula as P
import Data.List


data Alquiler = Alquiler
      { _id          :: Int
      , _videoclub   :: V.VideoClub
      , _cliente     :: C.Cliente
      , _pelicula    :: P.Pelicula
      } deriving (Eq,Show,Ord)

alquiler1  = Alquiler 1  V.videoclub1 C.cliente1  P.pelicula1
alquiler2  = Alquiler 2  V.videoclub1 C.cliente2  P.pelicula2
alquiler3  = Alquiler 3  V.videoclub1 C.cliente3  P.pelicula3
alquiler4  = Alquiler 4  V.videoclub2 C.cliente4  P.pelicula4
alquiler5  = Alquiler 5  V.videoclub2 C.cliente5  P.pelicula5
alquiler6  = Alquiler 6  V.videoclub2 C.cliente6  P.pelicula6
alquiler7  = Alquiler 7  V.videoclub3 C.cliente9  P.pelicula7
alquiler8  = Alquiler 8  V.videoclub3 C.cliente8  P.pelicula8
alquiler9  = Alquiler 9  V.videoclub3 C.cliente10 P.pelicula9
alquiler10 = Alquiler 10 V.videoclub1 C.cliente3  P.pelicula10
alquiler11 = Alquiler 11 V.videoclub1 C.cliente1  P.pelicula14
alquiler12 = Alquiler 12 V.videoclub1 C.cliente2  P.pelicula15


alquileres = [alquiler1,alquiler2,alquiler3,alquiler4,alquiler5,alquiler6,alquiler7,alquiler8,alquiler9,alquiler10,alquiler11,alquiler12]




-- ***************Clientes raros****************
-- ***********************************************

agruparporcliente = groupBy agruparPorCliente $ sortBy (\x y -> _cliente x `compare` _cliente y) alquileres

agruparporvideoclub alquileres = groupBy agruparPorVideoClub $ sortBy (\x y -> _videoclub x `compare` _videoclub y) alquileres

agruparporpelicula alquileres = groupBy agruparPorPelicula $ sortBy (\x y -> _pelicula x `compare` _pelicula y) alquileres

op = [[[_cliente a | a <- listadealquileres_v, (length (listadealquileres_v) >1)] | listadealquileres_v <- (agruparporvideoclub listadealquileres_c)] | listadealquileres_c <- (agruparporcliente)]


clientesRaros = mapM_ print $map (C.nombreApellidoCliente) $[head(head x) | x<- op, (x /= [[]])]


                               --[Funciones]--
                                                                                
alquilerDatos :: Alquiler -> String
alquilerDatos (Alquiler{_id=i,_videoclub=v,_cliente=c,_pelicula=p}) = show i ++"-"
                                                    ++"El cliente "++C.nombreApellidoCliente c++" alquilo la pelicula '"++P.tituloPelicula p
                                                    ++"' en el videoclub '"++V.nombreVideoClub v

clienteDatos :: C.Cliente -> V.VideoClub -> Alquiler -> P.Pelicula
clienteDatos cliente videoclub (Alquiler{_id=i,_videoclub=v,_cliente=c,_pelicula=p})= 
  if (cliente == c && videoclub==v) 
    then p
    else flag

flag = P.flag

tellAlquiler :: C.Cliente -> V.VideoClub -> P.Pelicula -> String 
tellAlquiler (C.Cliente{C._nombre=n,C._apellido=a}) (V.VideoClub{V._nombre=nvc}) (P.Pelicula{P._titulo=t}) =
             n ++ " " ++ a ++ " alquilo la pelicula " ++ t ++ " en el videoclub "++nvc 

--[]--


--   PelículasAlquiladasPorCliente, que devuelve una lista de películas que el cliente tiene alquiladas 
-- en el videoclub (esta función se indefine si el cliente no esta registrado en el videoclub). 
-- El cliente puede alquilar más de una copia de la misma película.

peliculasCliente cliente videoclub = filter (/=flag) $map (clienteDatos cliente videoclub) alquileres

listar_alquieres_cliente cliente videoclub = mapM_ print $map (tellAlquiler cliente videoclub) (peliculasCliente cliente videoclub) 

tiene_alquileres cliente videoclub = if ((peliculasCliente cliente videoclub)/=[]) then True else False

alquileresCliente :: IO()
alquileresCliente = do vc <- V.devuelveVideoclub
                       putStrLn "Seleccione el cliente.- "
                       V.listar_clientes vc
                       putStrLn "Numero del cliente: "
                       x <- readLn     
                       let cliente = C.clientes !! pred x
                       if (tiene_alquileres cliente vc) 
                        then listar_alquieres_cliente cliente vc
                        else putStrLn "Este cliente no tiene alquileres."

agruparPorCliente :: Alquiler -> Alquiler -> Bool
agruparPorCliente t1 t2 = _cliente t1 == _cliente t2                                                

agruparPorVideoClub :: Alquiler -> Alquiler -> Bool
agruparPorVideoClub t1 t2 = _videoclub t1 == _videoclub t2 

agruparPorPelicula :: Alquiler -> Alquiler -> Bool
agruparPorPelicula t1 t2 = _pelicula t1 == _pelicula t2

--groupBy agruparPorCliente $ sortBy (\x y -> _cliente x `compare` _cliente y) alquileres))



-------------------------------------------------------------------------------------------------------------

listar_alquileres = mapM_ print $map (alquilerDatos) alquileres

alquilada pelis = find (not . P._alquilada) pelis


--[Menu para cargar un alquiler]

cargarAlquiler :: [Alquiler] -> IO [Alquiler]
cargarAlquiler alquileres = do
  putStrLn "Ingresando datos alquiler.." 
  do videoclub <- V.devuelveVideoclub
     let pelis = V.peliculas_vc videoclub
     if ((alquilada pelis)== Nothing)
      then do putStrLn "Ninguna pelicula disponible para alquilar" >> return alquileres 
      else do putStrLn "Seleccione el cliente.- "
              V.listar_clientes videoclub
              putStrLn "Numero del cliente: "
              x <- readLn     
              let cliente = C.clientes !! pred x
              putStrLn "Seleccione la pelicula.-"
              V.listar_peliculas_disponibles videoclub
              putStrLn "Numero de la pelicula:"
              p <- readLn
              let pelicula = P.peliculas !! pred p     
              putStrLn "-.Alquiler cargado.-"
              let alquiler = Alquiler (length alquileres + 1) videoclub cliente pelicula
                  alquileres' = alquileres ++ [alquiler] 
              return alquileres'


listarAlquileres alquileres = mapM_ print $map (alquilerDatos) alquileres

opciones :: [(Int,(String))]
opciones = zip [1..] [("Cargar Alquiler"),("Listar Alquileres"),("Alquileres de un Cliente"),("Verificar si un cliente alquilo una pelicula especifica."),("Volver al menu anterior"),("Salir")]

concatIndice (i, (s)) = show i ++ ".) " ++ s

menu :: [Alquiler] -> IO [Alquiler]
menu alquileres = do
  putStrLn "Eliga su opcion: "
  putStrLn . unlines $ map concatIndice opciones
  str <- getLine
  case read str of
    1 -> do alquileres' <- cargarAlquiler alquileres             
            menu alquileres'
    2 -> listarAlquileres alquileres >> menu alquileres
    3 -> do videoclub <- V.devuelveVideoclub
            putStrLn "Seleccione el cliente: "
            V.listar_clientes videoclub
            putStrLn "Numero del cliente: "
            x <- readLn
            let cliente = C.clientes !! pred x
            listar_alquieres_cliente cliente videoclub
            menu alquileres
    4 -> do videoclub <- V.devuelveVideoclub
            putStrLn "Seleccione el cliente: "
            V.listar_clientes videoclub
            putStrLn "Numero del cliente: "
            x <- readLn
            let cliente = C.clientes !! pred x
            putStrLn "Seleccione la pelicula: "
            V.listar_peliculas_vc videoclub
            putStrLn "Numero de pelicula: "
            p <- readLn
            let pelicula = P.peliculas !! pred p
            verificar $alquilo cliente videoclub pelicula
            menu alquileres
    5 -> return alquileres    
    6 -> undefined
    _ -> putStrLn "Pruebe otra vez." >> menu alquileres


-- •     Alquiló, que indica si un cliente de un videoclub alquiló una película en particular.

alquilo cliente videoclub pelicula = elem (pelicula) $peliculasCliente cliente videoclub

verificar bool = if bool then putStrLn "El cliente si alquilo la pelicula." else putStrLn "Ese cliente no alquilo la pelicula."

alquiloPelicula :: IO()
alquiloPelicula = do videoclub <- V.devuelveVideoclub
                     putStrLn "Seleccione el cliente.- "
                     V.listar_clientes videoclub
                     putStrLn "Numero del cliente: "
                     x <- readLn     
                     let cliente = C.clientes !! pred x
                     putStrLn "Seleccione la pelicula.-"
                     V.listar_peliculas_vc videoclub
                     putStrLn "Numero de la pelicula:"
                     p <- readLn
                     let pelicula = P.peliculas !! pred p  
                     verificar $alquilo cliente videoclub pelicula
-- . -- . -- . -- .-- . -- . -- . --.-- . -- . -- . --.-- . -- . -- . --.-- . -- . -- . --

-- •     CopiasAlquiladas, que devuelve la cantidad de copias de la película dada que están alquiladas en un videoclub.



-- . -- . -- . -- .-- . -- . -- . --.-- . -- . -- . --.-- . -- . -- . --.-- . -- . -- . --