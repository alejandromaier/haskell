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
alquiler11 = Alquiler 11 V.videoclub2 C.cliente1  P.pelicula14

alquileres = [alquiler1,alquiler2,alquiler3,alquiler4,alquiler5,alquiler6,alquiler7,alquiler8,alquiler9,alquiler10]

alquilerDatos :: Alquiler -> String
alquilerDatos (Alquiler{_id=i,_videoclub=v,_cliente=c,_pelicula=p}) = show i ++"-"
                                                    ++"El cliente "++C.nombreApellidoCliente c++" alquilo la pelicula '"++P.tituloPelicula p
                                                    ++"' en el videoclub '"++V.nombreVideoClub v
listar_alquileres = mapM_ print $map (alquilerDatos) alquileres

alquilada pelis = find (not . P._alquilada) pelis

agruparPorCliente :: Alquiler -> Alquiler -> Bool
agruparPorCliente t1 t2 = C._nombre(_cliente t1) == C._nombre (_cliente t2)


agrupar_peliculas_cliente alquileres = groupBy agruparPorCliente $ sortBy (\x y -> _cliente x `compare` _cliente y) alquileres

-- peliculasPorCliente :: [Alquiler] -> [String]
-- peliculasPorCliente = nub . map _cliente

cargarAlquiler :: [Alquiler] -> IO [Alquiler]
cargarAlquiler alquileres = do
  putStrLn "Ingresando datos alquiler.." 
  do videoclub <- V.devuelveVideoclub
     let pelis = V.peliculas_vc videoclub
     if ((alquilada pelis)== Nothing)
      then do putStrLn "Ninguna pelicula disponible para alquilar" >> return alquileres 
      else do putStrLn "Seleccione el cliente.- "
              V.listar_clientes videoclub
              putStrLn "Numero del cliente: ."
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
opciones = zip [1..] [("Cargar Alquiler"),("Listar Alquileres"),("Volver al menu anterior"),("Salir")]

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
    3 -> return alquileres    
    4 -> undefined
    _ -> putStrLn "Pruebe otra vez." >> menu alquileres
