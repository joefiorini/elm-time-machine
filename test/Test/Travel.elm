module Test.Travel (tests) where

import Array

import ElmTest.Assertion (..)
import ElmTest.Test (..)

import TimeMachine.Travel as Travel
import TimeMachine.History as History

import Test.Helpers (..)

assertCurrent expected history =
  assertEqual expected <| .current history

tests =
  suite "Time Travel"

    [ suite "backward once"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| Travel.backward History.default
      , test "returns initial state after first entry"
        <| assertCurrent (Just startingStep)
        <| Travel.backward history1
      , test "returns firstStep after second entry"
        <| assertCurrent (Just firstStep)
        <| Travel.backward history2
      ]
    , suite "backward twice"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| (History.default |> Travel.backward << Travel.backward)
      , test "returns Nothing after first entry"
        <| assertCurrent Nothing
        <| (history1 |> Travel.backward << Travel.backward)
      , test "returns initial after second entry"
        <| assertCurrent (Just startingStep)
        <| (history2 |> Travel.backward << Travel.backward)
      ]
    , suite "foward after backward once"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| Travel.forward History.default
      , test "returns Nothing after first entry"
        <| assertCurrent Nothing
        <| Travel.forward history1
      , test "returns first entry after backward from first entry"
        <| assertCurrent (Just firstStep)
        <| (history1 |> Travel.backward >> Travel.forward)
      , test "returns second entry after backward from second entry"
        <| assertCurrent (Just secondStep)
        <| (history2 |> Travel.backward >> Travel.forward)
      ]
    , suite "forward after backward twice"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| (History.default |> Travel.backward >> Travel.backward >> Travel.forward)
      , test "returns starting step after first entry"
        <| assertCurrent (Just startingStep)
        <| (history1 |> Travel.backward >> Travel.backward >> Travel.forward)
      , test "returns Nothing entry after two redos from start"
        <| assertCurrent Nothing
        <| (history1 |> Travel.backward >> Travel.backward >> Travel.forward >> Travel.forward)
      ]
    , suite "backward once, forward twice"
      [ test "returns Nothing after first entry"
        <| assertCurrent Nothing
        <| (history1 |> Travel.backward >> Travel.forward >> Travel.forward)
      ]
    , suite "forking history"
      [ test "simple case"
        <| assertCurrent (Just secondStep)
        <| (history2 |> Travel.backward >> Travel.backward >>
          (History.record secondStep') >> Travel.backward)
      ]
    ]
