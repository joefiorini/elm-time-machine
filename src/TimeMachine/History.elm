module TimeMachine.History where

import List

type alias History a =
  { entries : List a
  , pointer : Int
  }

initial = -1

default =
  { entries = []
  , pointer = initial
  }

record : a -> History a -> History a
record entry history =
  let entries' = entry :: history.entries
      pointer' =
    if | List.length entries' == 0 -> initial
       | List.length entries' == 1 -> initial
       | otherwise -> history.pointer + 1
  in
  { history | entries <- entries'
            , pointer <- pointer' }
