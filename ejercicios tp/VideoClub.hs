module VideoClub where

data VideoClub = VideoClub
      { _id          :: Int
      , _nombre      :: String
      , _direccion   :: String
      } deriving Show

videoclub1 = VideoClub 1 "VHS Movies"           "25 de mayo 333"  
videoclub2 = VideoClub 2 "All the movies 4 you" "9 de julio 128"  
videoclub3 = VideoClub 3 "Hollywood movies"     "Buenos Aires 24"   

videclubs  = [videoclub1,videoclub2,videoclub3]
