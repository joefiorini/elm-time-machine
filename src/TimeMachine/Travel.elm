module TimeMachine.Travel exposing (..)

{-| Internal module containing implementation for time travel.
You might say it's what makes time travel possible. Like
the flux capacitor maybe?
|
-}

import Array


backward history =
    let
        current_ =
            Array.get history.pointer <| Array.fromList history.entries

        pointer_ =
            history.pointer + 1
    in
        { history
            | current = current_
            , pointer = pointer_
        }


forward history =
    let
        pointer_ =
            if history.pointer == 1 then
                -1
            else
                history.pointer - 2

        current_ =
            Array.get pointer_ <| Array.fromList history.entries
    in
        { history
            | current = current_
            , pointer = pointer_
        }
