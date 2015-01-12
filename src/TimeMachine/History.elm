module TimeMachine.History where

import List

type alias History a =
  { entries : List a
  , current : Maybe a
  , pointer : Int
  }

initial = -1

default =
  { entries = []
  , current = Nothing
  , pointer = 1
  }

record : a -> History a -> History a
record entry history =
  let entries' = entry :: history.entries
  in
  { history | entries <- entries' }
