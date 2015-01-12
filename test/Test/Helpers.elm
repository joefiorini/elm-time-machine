module Test.Helpers where

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

