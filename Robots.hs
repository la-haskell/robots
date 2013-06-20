
module Robots (compile_file) where 

import Data.Char (isSpace)
import Control.Monad
import UserAgent
import Path

data RobotsFile = RobotsFile [ RobotSection ]
type RobotChecker = UserAgent -> RobotsFile -> Path -> Bool
data RobotSection = RobotSection ( AgentChecker, PathChecker )

execute_file :: RobotsFile -> RobotChecker
execute_file = undefined

compile_file :: MonadPlus m => [ String ] -> m RobotsFile
compile_file = liftM RobotsFile . mapM compile_section . cutfile

data Section = Section (UserAgent, [ Path ])

type AgentChecker = UserAgent -> Bool
type PathChecker = Path -> Bool

compile_section :: MonadPlus m => [ String ] -> m RobotSection
compile_section (agent_line : url_lines) = 
                liftM RobotSection $
                liftM2 (,) (compile_agent_line agent_line)
                            (compile_url_lines url_lines)
-- compile_section = undefined

compile_agent_line :: MonadPlus m => String -> m AgentChecker
compile_agent_line ln = do
          dat <- checkKey "User-agent" ln
          return $ if (dat == "*") then const True else (== dat)

compile_url_lines :: MonadPlus m => [String] -> m PathChecker
compile_url_lines = \s -> mzero

cutfile :: [ String ] -> [[ String ]]
cutfile = undefined

splitLine :: String -> (String, String)
splitLine s = (k, trimL d) where (k, d) = splitat ':' s

-- split a string at the first instance of the specified character
splitat :: Char -> String -> (String, String)
splitat c [] = ([], [])
splitat c (d:ds) | c == d   = ([], ds)
                 | True     = (d:l, r) 
                                  where (l, r) = splitat c ds

trimL :: String -> String
trimL [] = []
trimL (c:cs) | isSpace c = trimL cs
             | True = c:cs

checkKey :: MonadPlus m => String -> String -> m String
checkKey k s | k == key    = return dat
             | True        = mzero
          where (key, dat) = splitLine s
