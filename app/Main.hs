{--
-- EPITECH PROJECT, 2024
-- Wolframe
-- File description:
-- Main
--}

module Main (main) where
import Lib
import System.Environment
import System.Exit (exitWith, ExitCode (ExitFailure))

main :: IO ()
main = do
    args <- getArgs
    if null args then
        displayHelp >> exitWith (ExitFailure 84)
        else
            let conf = case getOps defaultConf args of
                            Just c -> c
                            Nothing -> defaultConf
            in wolfram conf >> return ()