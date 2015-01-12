module TimeMachine.Travel where

import Array

backward history =
  Array.get 1 <| Array.fromList history.entries
