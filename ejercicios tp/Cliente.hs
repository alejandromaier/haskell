module Cliente where

data Cliente = Cliente
      { _id         :: Int
      , _nombre     :: String
      , _apellido   :: String
      , _edad       :: Int
      } deriving Show

cliente1 = Cliente 1  "Howard"    "Lovecraft" 46 
cliente2 = Cliente 2  "Charles"   "Ward"      26 
cliente3 = Cliente 3  "Marinus"   "Willett"   56  
cliente4 = Cliente 4  "William"   "Dyer"      53  
cliente5 = Cliente 5  "Frank"     "Pabodie"   49  
cliente6 = Cliente 6  "Herbert"   "West"      32  
cliente7 = Cliente 7  "Abdul"     "Alhazred"  71  
cliente8 = Cliente 8  "Alejandro" "Maier"     20 
cliente9 = Cliente 9  "Amilcar"   "Rey"       20   
cliente10= Cliente 10 "Seba"      "Calderon"  20  

clientes   = [cliente1, cliente2, cliente3, cliente4, cliente5, cliente6, cliente7, cliente8, cliente9, cliente10]