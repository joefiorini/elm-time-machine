module TimeMachine.History exposing (..)

{-| Internal module containing implementation for
History records
|
-}

import List


type alias History a =
    { entries : List a
    , current : Maybe a
    , pointer : Int
    }


initial =
    -1


default =
    { entries = []
    , current = Nothing
    , pointer = 1
    }


record : a -> History a -> History a
record entry history =
    let
        entries_ =
            entry :: history.entries
    in
        { history
            | entries = entries_
            , pointer = 1
        }
