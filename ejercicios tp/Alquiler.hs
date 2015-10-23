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

alquileres = [alquiler1,alquiler2,alquiler3,alquiler4,alquiler5,alquiler6,alquiler7,alquiler8,alquiler9,alquiler10]

alquilerDatos :: Alquiler -> String
alquilerDatos (Alquiler{_id=i,_videoclub=v,_cliente=c,_pelicula=p}) = show i ++"-"
                                                    ++"El cliente "++C.nombreApellidoCliente c++" alquilo la pelicula '"++P.tituloPelicula p
                                                    ++"' en el videoclub '"++V.nombreVideoClub v++"'"

listar_alquileres = mapM_ print $map (alquilerDatos) alquileres

alquilada pelis = find (not . P._alquilada) pelis

alquiler :: IO ()
alquiler = do putStrLn "Ingresando Datos Alquiler.."
              putStrLn "Videoclubs:"
              V.listar_videoclubs
              putStrLn "Ingrese el numero de un videoclub:"
              x <- readLn
              let videoclub = V.videoclubs !! pred x
              let pelis = V.peliculas_vc videoclub
              if ((alquilada pelis)== Nothing) 
                then do putStrLn "Ninguna pelicula disponible para alquilar" 
                else do putStrLn "Clientes:"
                        V.listar_clientes videoclub
                        putStrLn "Ingrese el numero de un cliente:"
                        c <- readLn
                        let cliente = C.clientes !! pred c
                        putStrLn "Peliculas:"
                        V.listar_peliculas_disponibles videoclub
                        putStrLn "Ingrese el numero de la pelicula:"
                        p <- readLn
                        let pelicula = P.peliculas !! pred p
                        let alquiler = Alquiler (length alquileres + 1) videoclub cliente pelicula
                        let alquileres' = alquileres ++ [alquiler]
                        putStrLn "Alquiler cargado.."
                        mapM_ print $map (alquilerDatos) alquileres'

