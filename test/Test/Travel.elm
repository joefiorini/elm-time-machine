module Test.Travel (tests) where

import ElmTest.Assertion (..)
import ElmTest.Test (..)

import TimeMachine.Travel as Travel
import TimeMachine.History as History

startingStep = []
firstStep = [1]
secondStep = [1,2]
thirdStep = [1,2,3]
fourthStep = [1,2,3,4]

history1 =
  History.record firstStep History.default

history2 =
  History.record firstStep >> History.record secondStep <| History.default

tests =
  suite "Time Travel"

    [ suite "backwards"
      [ test "returns initial state with no entries"
        <| assertEqual startingStep
        <| Travel.backwards History.default
      , test "returns initial state with 1 entry"
        <| assertEqual startingStep
        <| Travel.backwards history1
      , test "returns firstStep with 2 entries"
        <| assertEqual firstStep
        <| Travel.backwards history2
      ]
    ]
