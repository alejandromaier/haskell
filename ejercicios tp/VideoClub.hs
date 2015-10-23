module VideoClub where
import qualified Cliente as C
import qualified Pelicula as P
import Data.List


data VideoClub = VideoClub
      { _id          :: Int
      , _nombre      :: String
      , _direccion   :: String
      , _clientes    :: [C.Cliente]
      , _peliculas   :: [P.Pelicula]
      } deriving (Eq,Show,Ord)

videoclub1 = VideoClub 1 "VHS Movies"           "25 de mayo 333"  [C.cliente1,C.cliente2,C.cliente3]             [P.pelicula1,P.pelicula2,P.pelicula3,P.pelicula10]
videoclub2 = VideoClub 2 "All the movies 4 you" "9 de julio 128"  [C.cliente4,C.cliente5,C.cliente6]             [P.pelicula5,P.pelicula4,P.pelicula6,P.pelicula11,P.pelicula13]
videoclub3 = VideoClub 3 "Hollywood movies"     "Buenos Aires 24" [C.cliente7,C.cliente8,C.cliente9,C.cliente10] [P.pelicula7,P.pelicula8,P.pelicula9,P.pelicula12,P.pelicula14]

videoclubs  = [videoclub1,videoclub2,videoclub3]

indiceVideoClub :: VideoClub -> String
indiceVideoClub (VideoClub {_id=i,_nombre=n})= show i ++ ": " ++n ++ "\n"

nombreVideoClub :: VideoClub -> String
nombreVideoClub (VideoClub {_id=i,_nombre=n})= n

peliculas_vc videoclub = _peliculas (videoclub)


listar_clientes videoclub = mapM_ print $map (C.tellCliente) $_clientes (videoclub)
listar_peliculas videoclub = mapM_ print $map (P.tellPelicula) $_peliculas (videoclub)
listar_peliculas_disponibles videoclub = mapM_ print $map (P.tellPelicula) $filter (not . P._alquilada) $_peliculas (videoclub)
listar_videoclubs = mapM_ print $map (indiceVideoClub) videoclubs

clientes :: IO ()
clientes = do listar_videoclubs
              putStrLn "Ingrese el numero de un videoclub: "
              x <- readLn
              listar_clientes $videoclubs !! pred x


cargar :: IO ()
cargar = do putStrLn "Ingresado datos pelicula:"
            putStrLn "Titulo:"
            titulo <- getLine
            putStrLn "Ingrese Categoria: "
            P.listar_categorias_indices
            cat <- getLine
            let pelicula = P.Pelicula (length P.peliculas + 1) titulo False cat
            let peliculas' = P.peliculas ++ [pelicula]
            putStrLn "Pelicula cargada.."
            mapM_ print $map (P.estadoPeliculas) peliculas'