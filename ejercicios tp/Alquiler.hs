module Alquiler where
import qualified VideoClub as V
import qualified Cliente as C
import qualified Pelicula as P


data Alquiler = Alquiler
      { _id          :: Int
      , _videoclub   :: V.VideoClub
      , _cliente     :: C.Cliente
      , _pelicula    :: P.Pelicula
      } deriving Show