import System.IO
import System.Environment
import Data.List
import Data.Maybe

--runs the program
main = do
  args <- getArgs
  file <- readFile $ head args
  putStrLn $ process file
  
--tries looking up an example
process file = fromMaybe "" $ lookup example $ wordMap file
               where example = ("these", "O")
               
--creates a map of words to counts
wordMap file = map rowToTuple $ map words $ getWordtags file
               
--creates a tuple ((word, tag), count) from a WORDTAG entry
rowToTuple wordtag = ((word, tag), count)
                     where word = wordtag!!3
                           tag = wordtag!!2
                           count = head wordtag

--gets a list of WORDTAG entries from the file
getWordtags file = filter isWordtag $ lines file
                   where isWordtag = isInfixOf "WORDTAG"