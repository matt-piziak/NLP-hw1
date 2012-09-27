import System.IO
import System.Environment
import Data.List
import Data.Maybe
import qualified Data.Map as Map

--runs the program
main = do
  args <- getArgs
  file <- readFile $ head args
  let wordtags = getWordtags file
  print $ process wordtags
  
--gets a list of WORDTAG entries from the file
getWordtags file = filter isWordtag $ lines file
                   where isWordtag = isInfixOf "WORDTAG"

process wordtags = emit "these" "O" wordtags
                   
emit word tag wordtags = x / y
  where x = fromIntegral $ wordtagCount word tag wordtags
        y = fromIntegral $ totalWordCount word wordtags
                   
wordList wordtags = map getWord $ wordtags
                   where getWord line = (words line)!!3

totalWordCount word wordtags = sum $ map countOfTag tags
  where countOfTag tag = wordtagCount word tag wordtags
                     
wordtagCount word tag wordtags = read 
                                 $ fromMaybe "0" 
                                 $ Map.lookup (word, tag) 
                                 $ wordtagMap wordtags
                             
wordtagMap wordtags = Map.fromList $ map rowToTuple $ map words $ wordtags

--creates a tuple ((word, tag), count) from a WORDTAG entry
rowToTuple wordtag = ((word, tag), count)
                     where word = wordtag!!3
                           tag = wordtag!!2
                           count = head wordtag
                         
tags = [prefix++baseTag | prefix <- prefixes, baseTag <- baseTags]++other

prefixes = ["I-", "B-"]

baseTags = ["PER", "ORG", "LOC", "MISC"]

other = ["O"]