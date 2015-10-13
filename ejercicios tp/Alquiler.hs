module Alquiler where
import qualified VideoClub as V
import qualified Cliente as C
import qualified Pelicula as P


data Alquiler = Alquiler
      { _id          :: Int
      , _videoclub   :: V.VideoClub
      , _cliente     :: C.Cliente
      , _pelicula    :: P.Pelicula
      } deriving (Eq,Show,Ord)

alquileres = [alquiler1,alquiler2,alquiler3]

alquilerDatos :: Alquiler -> String
alquilerDatos (Alquiler{_id=i,_videoclub=v,_cliente=c,_pelicula=p}) = show i ++"-"
                                                    ++"El cliente "++C.nombreApellidoCliente c++" alquilo la pelicula '"++P.tituloPelicula p
                                                    ++"' en el videoclub '"++V.nombreVideoClub v++"'"



alquiler1 = Alquiler 1 V.videoclub1 C.cliente1 P.pelicula1
alquiler2 = Alquiler 2 V.videoclub2 C.cliente1 P.pelicula2
alquiler3 = Alquiler 3 V.videoclub1 C.cliente2 P.pelicula3

listar_alquileres = mapM_ print $map (alquilerDatos) alquileres