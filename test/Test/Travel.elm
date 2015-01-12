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
    , suite "foward after backward once"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| Travel.forward History.default
      , test "returns Nothing after first entry"
        <| assertCurrent Nothing
        <| Travel.forward history1
      , test "returns first entry after backward from first entry"
        <| assertCurrent (Just firstStep)
        <| (Travel.backward >> Travel.forward <| history1)
      , test "returns second entry after backward from second entry"
        <| assertCurrent (Just secondStep)
        <| (Travel.backward >> Travel.forward <| history2)
      ]
    , suite "forward after backward twice"
      [ test "returns Nothing with no entries"
        <| assertCurrent Nothing
        <| (Travel.backward >> Travel.backward >> Travel.forward <| History.default)
      , test "returns starting step after first entry"
        <| assertCurrent (Just startingStep)
        <| (Travel.backward >> Travel.backward >> Travel.forward <| history1)
      , test "returns Nothing entry after two redos from start"
        <| assertCurrent Nothing
        <| (Travel.backward >> Travel.backward >> Travel.forward >> Travel.forward <| history1)
      ]
    ]
