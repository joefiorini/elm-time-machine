module TimeMachine.History where

import List

type alias History a =
  { entries : List a
  }

initial = -1

default =
  { entries = []
  }

record : a -> History a -> History a
record entry history =
  let entries' = entry :: history.entries
  in
  { history | entries <- entries' }
