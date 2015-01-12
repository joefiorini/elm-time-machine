module Test.History (tests) where

import ElmTest.Assertion (..)
import ElmTest.Test (..)

import TimeMachine.History as History

startingStep = []
firstStep = [1]
secondStep = [1,2]
thirdStep = [1,2,3]
fourthStep = [1,2,3,4]

history2 =
  History.record firstStep History.default

history3 =
  History.record firstStep >> History.record secondStep <| History.default


tests =
  suite "History Record"

    [ suite "defaultHistory"
      [ test "past is empty list" <| assertEqual
        (.entries History.default)
        startingStep

      , test "pointer is at initial" <| assertEqual
        (.pointer History.default)
        History.initial
      ]

    , suite "after first entry"
        [ test "points at initial"
          <| assertEqual -1
            (History.record firstStep History.default |> .pointer)

        , test "entries contains first step"
          <| assertEqual [firstStep]
          (History.record firstStep History.default |> .entries
        )        ]

      , suite "after second entry"
        [ test "points at 0"
          <| assertEqual 0
            (History.record secondStep history2 |> .pointer)
        , test "entries contains first and second steps"
          <| assertEqual [secondStep, firstStep]
          (History.record secondStep history2 |> .entries)
        ]

      , suite "after third entry"
        [ test "points at 1"
          <| assertEqual 1
            (History.record thirdStep history3 |> .pointer)
        , test "entries contains first, second and third steps"
          <| assertEqual [ thirdStep, secondStep, firstStep ]
            (History.record thirdStep history3 |> .entries)
        ]
      ]
