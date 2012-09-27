import System.IO
import System.Environment
import Data.List
import Data.Maybe
import qualified Data.Map as Map

--runs the program
main = do
  args <- getArgs
  file <- readFile $ head args
  let wordtagLines = getWordtags file
  let onegramLines = getOneGrams file
  let wordtags = Map.fromList $ map lineToWordtag $ getWordtags file
  print $ wordtagCount "these" "O" wordtags
  
getWordtags :: String -> [[String]]
getWordtags file = map words $ filter (isInfixOf "WORDTAG")$ lines file
        
getOneGrams file = map words $ filter (isInfixOf "1-GRAM") $ lines file
                                  
wordtagCount :: String -> String -> Map.Map (String, String) Int -> Int
wordtagCount word tag wordtags = fromMaybe 0 $ Map.lookup (word, tag) wordtags

--creates a tuple ((word, tag), count) from a WORDTAG entry
lineToWordtag :: [String] -> ((String, String), Int)
lineToWordtag line@(count:marker:tag:word:_) = ((word, tag), read count)
  
                         
tags = [prefix++baseTag | prefix <- prefixes, baseTag <- baseTags]++other

prefixes = ["I-", "B-"]

baseTags = ["PER", "ORG", "LOC", "MISC"]

other = ["O", "STOP", "*"]