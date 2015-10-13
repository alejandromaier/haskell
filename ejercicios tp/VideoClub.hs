module VideoClub where
import qualified Cliente as C

data VideoClub = VideoClub
      { _id          :: Int
      , _nombre      :: String
      , _direccion   :: String
      , _clientes    :: [C.Cliente]
      } deriving (Eq,Show,Ord)

videoclub1 = VideoClub 1 "VHS Movies"           "25 de mayo 333"  []  
videoclub2 = VideoClub 2 "All the movies 4 you" "9 de julio 128"  []
videoclub3 = VideoClub 3 "Hollywood movies"     "Buenos Aires 24" [] 

videoclubs  = [videoclub1,videoclub2,videoclub3]

indiceVideoClub :: VideoClub -> String
indiceVideoClub (VideoClub {_id=i,_nombre=n})= show i ++ ": " ++n 

nombreVideoClub :: VideoClub -> String
nombreVideoClub (VideoClub {_id=i,_nombre=n})= n 

listar_videoclubs = mapM_ print $map (indiceVideoClub) videoclubs


-- main = do listar_videoclubs
--           putStrLn "Ingrese el numero de un videoclub: "
--           x <- readLn 
--           