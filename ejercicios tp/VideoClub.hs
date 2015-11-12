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

videoclub1 = VideoClub 1 "VHS Movies"           "25 de mayo 333"  [C.cliente1,C.cliente2,C.cliente3]             [P.pelicula1,P.pelicula2,P.pelicula3,P.pelicula10,P.pelicula14,P.pelicula15]
videoclub2 = VideoClub 2 "All the movies 4 you" "9 de julio 128"  [C.cliente4,C.cliente5,C.cliente6]             [P.pelicula5,P.pelicula4,P.pelicula6,P.pelicula11,P.pelicula13]
videoclub3 = VideoClub 3 "Hollywood movies"     "Buenos Aires 24" [C.cliente7,C.cliente8,C.cliente9,C.cliente10] [P.pelicula7,P.pelicula8,P.pelicula9,P.pelicula12, P.pelicula1]

videoclubs  = [videoclub1,videoclub2,videoclub3]



-- ¨*********************************
--BuscarPeli, devuelve un listado con los videoclubs que tienen una determinada película.*
-- **********************************
--algo :: P.Pelicula -> [VideoClub]
algo pelicula = [ v | v <- videoclubs, (elem (pelicula) $(_peliculas) v) == True ]
--map (nombreVideoClub) algo



indiceVideoClub :: VideoClub -> String
indiceVideoClub (VideoClub {_id=i,_nombre=n})= show i ++ ": " ++n ++ "\n"

nombreVideoClub :: VideoClub -> String
nombreVideoClub (VideoClub {_id=i,_nombre=n})= n

peliculas_vc videoclub = _peliculas (videoclub)


-- *****************************--
-- **  Disponible en la red   **--
-- *****************************
--disponibleEnLaRed, que dice si la película está disponible en al menos alguno de los videoclubs de la red.
--devuelve true si la pelicula esta disponible. 
is_na pelicula = elem (pelicula) P.peliculas_na
is_in_vc pelicula videoclub  = if (elem (pelicula) $ (_peliculas) videoclub) then _nombre(videoclub) else ""
en_el_videoclub pelicula = head $filter (/= "") $map (is_in_vc pelicula) videoclubs
disponible_en_la_red pelicula = if(is_na pelicula) then "La pelicula esta disponible en el videoclub "++ en_el_videoclub pelicula  else "La pelicula no esta disponible"


--verificar  = if bool then putStrLn "El cliente si alquilo la pelicula." else putStrLn "Ese cliente no alquilo la pelicula."

listar_clientes videoclub = mapM_ print $map (C.tellCliente) $_clientes (videoclub)
listar_peliculas videoclub = mapM_ print $map P.concatIndice $P.zipeando $P.peliculaNombre $_peliculas (videoclub)
listar_peliculas_vc videoclub = mapM_ print $map (P.peliculaIndice) $_peliculas (videoclub)
listar_peliculas_disponibles videoclub = mapM_ print $map (P.tellPelicula) $filter (not . P._alquilada) $_peliculas (videoclub)
listar_videoclubs = mapM_ print $map (indiceVideoClub) videoclubs

devuelveVideoclub :: IO VideoClub
devuelveVideoclub = do putStrLn "Videoclubs: "                       
                       listar_videoclubs
                       putStrLn "Ingrese el numero de un videoclub: "
                       x <- readLn
                       let videoclub = videoclubs !! pred x
                       return videoclub

clientes :: IO ()
clientes = do listar_videoclubs
              putStrLn "Ingrese el numero de un videoclub: "
              x <- readLn
              listar_clientes $videoclubs !! pred x

copias_p :: IO () 
copias_p = do let videoclub = videoclub3
              let pelis = _peliculas videoclub 
              let p_indice = P.peliculaNombre pelis             
              putStrLn "Ingrese el numero de una Pelicula:"
              listar_peliculas videoclub
              p <- readLn
              let pelicula = p_indice !! pred p
              let copias = show $length $filter (==pelicula) $map (P.tituloPelicula) pelis
              let pcopias= "Pelicula: "++ pelicula ++", copias: "++ copias
              putStrLn pcopias

cargarVideoclub :: [VideoClub] -> IO [VideoClub]
cargarVideoclub videoclubs = do
  putStrLn "Ingresando datos videoclub.." 
  putStrLn "Nombre: "
  nombre <- getLine
  putStrLn "Direccion: "
  dir <- getLine
  let clientes = []
      peliculas = []
  let videoclub = VideoClub (length videoclubs + 1) nombre dir clientes peliculas
      videoclubs' = videoclubs ++ [videoclub] 
  return videoclubs'


listarVideoclubs videoclubs = mapM_ print $map (nombreVideoClub) videoclubs

opciones :: [(Int,(String))]
opciones = zip [1..] [("Cargar Videoclub"),("Listar Videoclubs"),("Volver al menu anterior"),("Salir")]

concatIndice (i, (s)) = show i ++ ".) " ++ s

menu :: [VideoClub] -> IO [VideoClub]
menu videoclubs = do
  putStrLn "Eliga su opcion: "
  putStrLn . unlines $ map concatIndice opciones
  str <- getLine
  case read str of
    1 -> do videoclubs' <- cargarVideoclub videoclubs             
            menu videoclubs'
    2 -> listarVideoclubs videoclubs >> menu videoclubs
    3 -> return videoclubs    
    4 -> undefined
    _ -> putStrLn "Pruebe otra vez." >> menu videoclubs



