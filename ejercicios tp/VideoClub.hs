module VideoClub where
import qualified Cliente as C


data VideoClub = VideoClub
      { _id          :: Int
      , _nombre      :: String
      , _direccion   :: String
      , _clientes    :: [C.Cliente]
      } deriving (Eq,Show,Ord)

videoclub1 = VideoClub 1 "VHS Movies"           "25 de mayo 333"  [C.cliente1,C.cliente2,C.cliente3]
videoclub2 = VideoClub 2 "All the movies 4 you" "9 de julio 128"  [C.cliente4,C.cliente5,C.cliente6]
videoclub3 = VideoClub 3 "Hollywood movies"     "Buenos Aires 24" [C.cliente7,C.cliente8,C.cliente9,C.cliente10]

videoclubs  = [videoclub1,videoclub2,videoclub3]

indiceVideoClub :: VideoClub -> String
indiceVideoClub (VideoClub {_id=i,_nombre=n})= show i ++ ": " ++n ++ "\n"

nombreVideoClub :: VideoClub -> String
nombreVideoClub (VideoClub {_id=i,_nombre=n})= n


-- el videoclub tendra que tener las peliculas ????????
-- listar_peliculas_cliente videoclub cliente = mapM_ print $map () -- <------- VER COMO HACER..
listar_clientes videoclub = mapM_ print $map (C.tellCliente) $_clientes (videoclub)
listar_videoclubs = mapM_ print $map (indiceVideoClub) videoclubs

clientes :: IO ()
clientes = do listar_videoclubs
              putStrLn "Ingrese el numero de un videoclub: "
              x <- readLn
              listar_clientes $videoclubs !! pred x

peliculas :: IO ()
peliculas = do clientes
               putStrLn "Ingrese el numero de un cliente"
               b <- readLn -- cliente
               let cliente = C.clientes !! pred b
               C.tellCliente cliente
              --  listar_peliculas_cliente videoclub cliente --se lista las peliculas del cliente en ese videoclub
