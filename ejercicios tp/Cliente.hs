module Cliente where

data Cliente = Cliente
      { _id         :: Int
      , _nombre     :: String
      , _apellido   :: String
      , _edad       :: Int
      } deriving (Eq,Show,Ord)

cliente1 = Cliente 1  "Facu"      "Posse"     20
cliente2 = Cliente 2  "Julian"    "Maier"     17
cliente3 = Cliente 3  "Cacho"     "Nakamura"  56
cliente4 = Cliente 4  "Mati"      "Chauchis"  53
cliente5 = Cliente 5  "Fede"      "Calderon"  49
cliente6 = Cliente 6  "Juan"      "Burni"     32
cliente7 = Cliente 7  "Pablo"     "Escobar"   71
cliente8 = Cliente 8  "Alejandro" "Maier"     20
cliente9 = Cliente 9  "Amilcar"   "Rey"       20
cliente10= Cliente 10 "Seba"      "Calderon"  20

clientes   = [cliente1, cliente2, cliente3, cliente4, cliente5, cliente6, cliente7, cliente8, cliente9, cliente10]

nombreApellidoCliente :: Cliente -> String
nombreApellidoCliente (Cliente {_id = i,_nombre = n, _apellido = a }) = a ++", "++ n

tellCliente :: Cliente -> String
tellCliente (Cliente {_id = i,_nombre = n, _apellido = a }) = "Cliente "++ show i ++ ": " ++ a ++", "++ n

listaCliente :: Cliente -> String
listaCliente (Cliente {_id = i,_nombre = n, _apellido = a }) = "Cliente "++ ": " ++ a ++", "++ n

listar_clientes         = mapM_  print $map (listaCliente)       clientes