module Intro exposing (Section, data)

type alias Section =
  { title       : String
  , url         : Maybe String
  , description : String
  }

data : List Section
data =
  [
  ]
