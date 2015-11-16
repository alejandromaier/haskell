module Cliente where

data Cliente = Cliente
      { _id         :: Int
      , _nombre     :: String
      , _apellido   :: String
      , _edad       :: Int
      } deriving (Eq,Show,Ord)

cliente1 = Cliente 1  "Facundo"   "Posse"     20
cliente2 = Cliente 2  "Julian"    "Maier"     17
cliente3 = Cliente 3  "Cacho"     "Nakamura"  56
cliente4 = Cliente 4  "Mati"      "Chauchis"  53
cliente5 = Cliente 5  "Fede"      "Carrion"  49
cliente6 = Cliente 6  "Juan"      "Burni"     32
cliente7 = Cliente 7  "Pablo"     "Escobar"   71
cliente8 = Cliente 8  "Alejandro" "Maier"     20
cliente9 = Cliente 9  "Amilcar"   "Rey"       20
cliente10= Cliente 10 "Seba"      "Calderon"  20

flag     = Cliente 0 "" "" 0

clientes   = [cliente1, cliente2, cliente3, cliente4, cliente5, cliente6, cliente7, cliente8, cliente9, cliente10]

nombreApellidoCliente :: Cliente -> String
nombreApellidoCliente (Cliente {_id = i,_nombre = n, _apellido = a }) = a ++", "++ n

tellCliente :: Cliente -> String
tellCliente (Cliente {_id = i,_nombre = n, _apellido = a }) = "Cliente "++ show i ++ ": " ++ a ++", "++ n

listaCliente :: Cliente -> String
listaCliente (Cliente {_id = i,_nombre = n, _apellido = a }) = "Cliente: " ++ a ++", "++ n

listar_clientes         = mapM_  print $map (listaCliente)       clientes


cargarCliente :: [Cliente] -> IO [Cliente]
cargarCliente clientes = do
  putStrLn "Ingresando datos cliente.." 
  putStrLn "Nombre: "
  nombre <- getLine
  putStrLn "Apellido: "
  apellido <- getLine
  putStrLn "Edad: "
  edad <- readLn
  putStrLn "-.Cliente cargado.-"
  let cliente = Cliente (length clientes + 1) nombre apellido edad
      clientes' = clientes ++ [cliente] 
  return clientes'


listarClientes clientes = mapM_ print $map (listaCliente) clientes

opciones :: [(Int,(String))]
opciones = zip [1..] [("Cargar Cliente"),("Listar Clientes"),("Volver al menu anterior"),("Salir")]

concatIndice (i, (s)) = show i ++ ".) " ++ s

menu :: [Cliente] -> IO [Cliente]
menu clientes = do
  putStrLn "Eliga su opcion: "
  putStrLn . unlines $ map concatIndice opciones
  str <- getLine
  case read str of
    1 -> do clientes' <- cargarCliente clientes             
            menu clientes'
    2 -> listarClientes clientes >> menu clientes
    3 -> return clientes    
    4 -> undefined
    _ -> putStrLn "Pruebe otra vez." >> menu clientes

devuelveCliente :: IO Cliente
devuelveCliente = do putStrLn "Clientes: "                       
                     listar_clientes
                     putStrLn "Ingrese el numero de un cliente:"
                     x <- readLn
                     let cliente = clientes !! pred x
                     return cliente