module Test.History (tests) where

import ElmTest.Assertion (..)
import ElmTest.Test (..)

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


tests =
  suite "History Record"

    [ suite "defaultHistory"
      [ test "past is empty list" <| assertEqual
        (.entries History.default)
        startingStep
      ]

    , suite "at initial entry"
        [ test "entries contains first step"
          <| assertEqual [startingStep]
          (History.record startingStep History.default |> .entries)
        ]
    , suite "after first entry"
        [ test "entries contains first step"
          <| assertEqual [firstStep, startingStep]
          (History.record firstStep history0 |> .entries)
        ]

      , suite "after second entry"
        [ test "entries contains first and second steps"
          <| assertEqual [secondStep, firstStep, startingStep]
          (History.record secondStep history1 |> .entries)
        ]

      , suite "after second entry"
        [ test "entries contains first, second and third steps"
          <| assertEqual [ thirdStep, secondStep, firstStep, startingStep ]
            (History.record thirdStep history2 |> .entries)
        ]
      ]
