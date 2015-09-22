module Pelicula where

import qualified VideoClub as V
data Pelicula = Pelicula
      { _id          :: Int
      , _titulo      :: String
      , _alquilada   :: Bool
      , _videoclub   :: V.VideoClub
      , _categoria   :: String
      } deriving Show

-- PARA MI ESTA MAL ACA LAS PELICULAS deberias ser como clientes, definirlas y luego usarlas, me parece.. <--VER

--          |Tipo    |id |    titulo pelicula             | alquilada?| Videclub    |   categoria   |   cliente?  |
pelicula1  = Pelicula 1   "At the Mountains of Madness"       True      V.videoclub1      "Ficción"     
pelicula2  = Pelicula 2   "The Case of Charles Dexter Ward"   True      V.videoclub1      "Ficción"      
pelicula3  = Pelicula 3   "Herbert West -- The Re-animator"   True      V.videoclub1      "Ficción"      
pelicula4  = Pelicula 4   "The Call"                          True      V.videoclub1      "Miedo"      
pelicula5  = Pelicula 5   "Frozen"                            True      V.videoclub2      "Fantasía"      
pelicula6  = Pelicula 6   "Fight Club"                        False     V.videoclub2      "Acción"      
    

peliculas  = [pelicula1, pelicula2, pelicula3, pelicula4, pelicula5, pelicula6]