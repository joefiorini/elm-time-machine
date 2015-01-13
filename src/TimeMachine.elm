module TimeMachine where

import TimeMachine.History as History
import TimeMachine.Travel as Travel

type alias History a = History.History a

record = History.record

travelBackward = Travel.backward
travelForward = Travel.forward

initialize : a -> History a
initialize =
   flip record History.default
