module TimeMachine.Travel where

import Array

backward history =
  let current' = Array.get history.pointer <| Array.fromList history.entries
      pointer' = history.pointer + 1
  in
    { history | current <- current'
              , pointer <- pointer' }
