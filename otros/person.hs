elementAt :: [a] -> Int -> a
elementAt list i    = list !! (i-1)

data Cliente = Cliente { nombre :: String
                     , apellido :: String
                     , telefono :: String
                     , edad :: Int
                     } deriving (Eq, Ord, Show)

cliente1 = Cliente {nombre="Alejandro",apellido="Maier",telefono="1231251",edad=21}
cliente2 = Cliente {nombre="Pablo",apellido="Marrone",telefono="7162922",edad=20}
cliente3 = Cliente {nombre="Julian",apellido="Maier",telefono="63245234",edad=20}
cliente4 = Cliente {nombre="Amilcar",apellido="Rey",telefono="63242234",edad=18}
cliente5 = Cliente {nombre="Seba",apellido="Calderon",telefono="7162692",edad=20}
cliente6 = Cliente {nombre="Fede",apellido="Carrion",telefono="612618516",edad=18}
cliente7 = Cliente {nombre="Mati",apellido="Nikolaus",telefono="2126132",edad=19}
cliente8 = Cliente {nombre="Facu",apellido="Posse",telefono="612621816",edad=20}

clientes = [cliente1,cliente2,cliente3,cliente4,cliente5,cliente6,cliente7,cliente8]

elementos_lista = length clientes

list = reverse clientes

nombre_apellido x = nombre (list !! x) ++ " " ++ apellido (list !! x)

recorre p = if p>=0 then "Cliente "++ nombre_apellido p ++"\n"++ recorre (p-1) else ""

listar_cliente x =  nombre (clientes !! x) ++ " "++ apellido (clientes !! x)

mostrar_edad person = print (edad person)

listar_clientes = recorre $ elementos_lista-1



