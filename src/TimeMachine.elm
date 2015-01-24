module TimeMachine where

{-| This module is the entry point to the TimeMachine library. It works best if you wrap a record that is nested in your top-level state, rather than the top-level state itself.

For example, this would trigger a compile error:

    type alias AppState =
      { current : Maybe Contact
      , history : TimeMachine.History AppState
      }

You need to track the state on the `Contact` record instead like this:

    type alias AppState =
      { current : Maybe Contact
      , history : TimeMachine.History (Maybe Contact)
      }

## Traveling through Time (Undo/Redo)
@docs travelBackward, travelForward

## Recording History
@docs record, History

|-}

import TimeMachine.History as History
import TimeMachine.Travel as Travel

type alias History a = History.History a

{-| Record an entry in the history so you can travel
to it later.

  let history = History.initialize initialState
  in
     History.record newState history

|-}
record = History.record

{-| Returns a history record with `current` set to
1 step backward in time, or `Nothing` if past the
beginning of time.

    let history = TimeMachine.travelBackward state.history
    in
       case history.current of
         Just s ->
           { state | current <- s
                   , history <- history
           }
         Nothing -> state
|-}
travelBackward = Travel.backward

{-| Returns a history record with `current` set to
1 step forward in time.

    let history = TimeMachine.travelForward state.history
    in
       case history.current of
         Just s ->
           { state | current <- s
                   , history <- history
           }
         Nothing -> state
|-}
travelForward = Travel.forward

{-| Returns a history record with the passed in
object as the initial state. Meant to be used in
your `initialState` function.

    initialState =
      { current = Nothing
      , history = TimeMachine.initialize Model.initialState
      }
|-}
initialize : a -> History a
initialize =
   flip record History.default
