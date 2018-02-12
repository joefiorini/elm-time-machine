module TimeMachine.History exposing (..)

{-| Internal module containing implementation for
History records
|
@docs initial, default, record, History
-}

import List


{-| The model type for History records
-}
type alias History a =
    { entries : List a
    , current : Maybe a
    , pointer : Int
    }


{-| The initial pointer, internal
-}
initial : Int
initial =
    -1


{-| The default state, internal
-}
default : History a
default =
    { entries = []
    , current = Nothing
    , pointer = 1
    }


{-| Your history entries
-}
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
