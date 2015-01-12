module Test.Travel (tests) where

import Array

import ElmTest.Assertion (..)
import ElmTest.Test (..)

import TimeMachine.Travel as Travel
import TimeMachine.History as History

startingStep = []
firstStep = [1]
secondStep = [1,2]
thirdStep = [1,2,3]
fourthStep = [1,2,3,4]

history0 =
  History.record startingStep History.default

history1 =
  History.record startingStep >>
    History.record firstStep <| History.default

history2 =
  History.record startingStep >>
    History.record firstStep >>
      History.record secondStep <| History.default

assertCurrent expected history =
  assertEqual expected <| .current history
tests =
  suite "Time Travel"

    [ suite "backward once"
      [ test "returns Nothing with no entries"
        <| assertEqual Nothing
        <| (Travel.backward History.default |> .current)
      , test "returns initial state after first entry"
        <| assertEqual (Just startingStep)
        <| (Travel.backward history1 |> .current)
      , test "returns firstStep after second entry"
        <| assertEqual (Just firstStep)
        <| (Travel.backward history2 |> .current)
      ]
    , suite "backward twice"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| (Travel.backward << Travel.backward <| History.default)
      , test "returns Nothing after first entry"
        <| assertCurrent Nothing
        <| Travel.backward << Travel.backward <| history1
      , test "returns initial after second entry"
        <| assertCurrent (Just startingStep)
        <| (Travel.backward << Travel.backward <| history2)
      ]
    ]
