{--
-- EPITECH PROJECT, 2024
-- Wolframe
-- File description:
-- Lib
--}

module Lib (Conf, defaultConf, getOps, displayHelp, wolfram) where
import Text.Read (readMaybe)
import System.Exit (exitWith, ExitCode (ExitFailure))
import Data.Maybe

type ListG = Int
type ListD = Int


data Conf = Conf {
    rule :: Maybe Int,
    move :: Maybe Int,
    start :: Maybe Int,
    line :: Maybe Int,
    window :: Maybe Int
}

defaultConf::Conf
defaultConf = Conf {
  rule = Nothing,
  move = Just 0,
  line = Nothing,
  start = Just 0,
  window = Just 80
}


-- Display Function

displayHelp :: IO ()
displayHelp = putStrLn "USAGE: ./wolfram --rule n --start n --lines n --window n\
  \ --move n\n\n\
  \DESCRIPTION\n\
  \    --rule n    rule to use (0 < n < 255)\n\
  \    --start n   start line (0 < n)\n\
  \    --lines n   number of lines to print (0 < n)\n\
  \    --window n  size of the window (0 < n)\n\
  \    --move n    move the window (0 < n)"

printListD :: [Int] -> Int -> IO ()
printListD _ 0 = return ()
printListD [] _ = return ()
printListD (a:x) index =
  if a == 0
    then putStr " "  >> printListD x (index - 1)
    else putStr "*" >> printListD x (index - 1)

printListG :: [Int] -> Int -> IO ()
printListG _ 0 = return ()
printListG [] _ = return ()
printListG a index =
  if (a !! (index - 1)) == 0
    then putStr " "  >> printListG a (index - 1)
    else putStr "*" >> printListG a (index - 1)

displayFunction :: Conf -> [ListG] -> [ListD] -> IO()
displayFunction conf listg listd =
  if fromJust (start conf) == 0
    then
      printListG listg ((fromJust (window conf) `div` 2)+fromJust (move conf))
 >> printListD listd ((fromJust (window conf) `div` 2)+(-fromJust (move conf)))
    >> putStr "\n" >> case line conf of
      Just s -> loopFunction conf { line = Just (s - 1) } listg listd
      Nothing -> loopFunction conf listg listd
    else loopFunction
    conf { start = Just (fromJust (start conf) - 1) } listg listd


-- Binairy Translate and Rules

toBinaryArray :: Int ->  Int -> [Int]
toBinaryArray 1 _ = []
toBinaryArray bits n =
  if n >= bits `div` 2
    then 1 : toBinaryArray (bits `div` 2) (n - (bits `div` 2))
    else 0 : toBinaryArray (bits `div` 2) n


rules :: [Int] -> [Int] -> Int
rules [1, 1, 1] tab = tab !! 0
rules [1, 1, 0] tab = tab !! 1
rules [1, 0, 1] tab = tab !! 2
rules [1, 0, 0] tab = tab !! 3
rules [0, 1, 1] tab = tab !! 4
rules [0, 1, 0] tab = tab !! 5
rules [0, 0, 1] tab = tab !! 6
rules [0, 0, 0] tab = tab !! 7
rules _ _ = -1


-- Get and Check ARGS

getOps :: Conf -> [String] -> Maybe Conf
getOps conf [] = Just conf
getOps conf ("--rule":val:end) = getOps (conf { rule = readMaybe val }) end
getOps conf ("--move":val:end) = getOps (conf { move = readMaybe val }) end
getOps conf ("--start":val:end) = getOps (conf { start = readMaybe val }) end
getOps conf ("--lines":val:end) = getOps (conf { line = readMaybe val }) end
getOps conf ("--window":val:end) = getOps (conf { window = readMaybe val }) end
getOps _ _ = Nothing

argsValid :: Conf -> Bool
argsValid conf =
  case rule conf of
    Nothing -> False
    Just s -> s > 0 && s <= 255

moveTo :: [Int] -> Int -> [Int]
moveTo a 0 = a
moveTo (_:rest) index = moveTo rest (index - 1)
moveTo [] _ = []


-- Generation gen and Loop

genInit :: Conf -> [ListG] -> [ListD] -> IO()
genInit conf listg listd =
  let params = toBinaryArray 256 (fromJust (rule conf))
      listg1 =
       rules [listg !! 1, head listg, head listd] params:zipWith3
       (\a b c -> rules [c,b,a] params) listg (moveTo listg 1) (moveTo listg 2)
      listd2 =
       rules [head listg, head listd, listd !! 1] params:zipWith3
       (\a b c -> rules [a,b,c] params) listd (moveTo listd 1) (moveTo listd 2)
  in displayFunction conf listg1 listd2

loopFunction :: Conf -> [ListG] -> [ListD] -> IO ()
loopFunction conf listg listd =
  case line conf of
    Just 0 -> return ()
    _ -> genInit conf listg listd


-- Initialisation and starting func

initialisationFunction :: Conf -> IO ()
initialisationFunction conf =
  let listg = repeat 0
      listd = 1 : repeat 0
  in displayFunction conf listg listd >> return ()


wolfram :: Conf -> IO()
wolfram conf =
    if argsValid conf == False
      then displayHelp >> exitWith (ExitFailure 84)
      else initialisationFunction conf
