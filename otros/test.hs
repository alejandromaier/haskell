main = do
    putStrLn "This works"

inserta :: Ord a => a -> [a] -> [a]
inserta e []     = [e]
inserta e (x:xs)
    | e <= x     = e:x:xs
    | otherwise  = x :  inserta e xs

foldl' f z []     = z
foldl' f z (x:xs) = let z' = z `f` x
                   in seq z' $ foldl' f z' xs
sum3 = foldl' (+) 0
	