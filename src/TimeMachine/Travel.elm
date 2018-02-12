module TimeMachine.Travel exposing (..)

{-| Internal module containing implementation for time travel.
You might say it's what makes time travel possible. Like
the flux capacitor maybe?

@docs backward, forward
|

-}

import Array
import TimeMachine.History exposing (History)


{-| Internal, do not use
-}
backward : History a -> History a
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


{-| Internal, do not use
-}
forward : History a -> History a
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
