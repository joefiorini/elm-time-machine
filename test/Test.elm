module Main where

import String

import IO.IO (..)
import IO.Runner (Request, Response, run)
import ElmTest.Test (test, Test, suite)
import ElmTest.Assertion (assert, assertEqual)
import ElmTest.Runner.Console (runDisplay)

import Test.History as History

tests : Test
tests = suite "A Test Suite"
        [ History.tests
        ]

port requests : Signal Request
port requests = run responses (runDisplay tests)

port responses : Signal Response
