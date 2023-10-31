splitByDelimiter :: Char -> String -> [String] -> [String]
splitByDelimiter delim s sl
    | length s == 0 = sl
    | head s == delim = splitByDelimiter delim (tail s) (sl ++ [""])
    | ( head s /= delim ) && length sl == 1 = splitByDelimiter delim (tail s) [(head sl ++ [head s])] 
    | otherwise = splitByDelimiter delim (tail s) ( init sl ++ [last sl ++ [head s]])

intListFromString :: String -> [Int]
intListFromString s =
    map (read::String->Int) (splitByDelimiter ',' ( filter ( `elem` (['0'..'9'] ++ ",") ) s ) [""])

getTargets t l = zip (map (t-) l) [0..(length l)]

checkTuple x l t
    | x == fst l = False
    | x + fst l == t = True
    | otherwise = False

checkTuples x l t
    | length l == 0 = 0
    | checkTuple x (head l) t == True = snd(head l) 
    | otherwise = checkTuples x (tail l) t

twoSum t l = 
    filter (/=0) $ map (\x -> checkTuples x (getTargets t l) t) (map (t-) l)

twoSum' t = twoSum (fst t) (snd t)

main :: IO ()
main = do
    src <- readFile "two_sum"
    let pairs = map (\x -> splitByDelimiter '|' x [""]) (lines src)
    let lists = map intListFromString ( map last pairs ) 
    let targets = map (read::String->Int) (map head pairs)
    print $ map (twoSum') (zip targets lists)
    