module Test.History (tests) where

import ElmTest.Assertion (..)
import ElmTest.Test (..)

import TimeMachine.History as History

import Test.Helpers (..)

tests =
  suite "History Record"

    [ suite "defaultHistory"
      [ test "past is empty list" <| assertEqual
        (.entries History.default)
        startingStep
      , test "current is Nothing"
        <| assertEqual Nothing (.current History.default)
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
