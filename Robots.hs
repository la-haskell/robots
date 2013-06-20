
module Robots (compile_file) where 

import UserAgent
import Path

data RobotsFile = RobotsFile [ RobotSection ]
type RobotChecker = UserAgent -> RobotsFile -> Path -> Bool
data RobotSection = RobotSection ( AgentChecker, PathChecker )

execute_file :: RobotsFile -> RobotChecker
execute_file = undefined

compile_file :: [ String ] -> RobotsFile
compile_file = RobotsFile . map compile_section . cutfile

data Section = Section (UserAgent, [ Path ])

type AgentChecker = UserAgent -> Bool
type PathChecker = Path -> Bool

compile_section :: [ String ] -> RobotSection
compile_section (agent_line : url_lines) = 
                RobotSection
                (compile_agent_line agent_line,
                compile_url_lines url_lines)

compile_agent_line :: String -> AgentChecker
compile_agent_line = undefined

compile_url_lines :: [String] -> PathChecker
compile_url_lines = undefined

cutfile :: [ String ] -> [[ String ]]
cutfile = undefined

