module Essay exposing (Essay, Content(..), essays)

type Content
    = P String
    | I String
    | L String

type Date = D Int Int Int

type alias Essay =
    { id: String
    , date: Date
    , title: String
    , contents: List Content
    }

humbleMind: Essay
humbleMind = Essay "humble-mind" (D 2019 11 21)
    "이기적 겸손"
    [ P "적절히 겸손한 태도는 남들에게 편안한 느낌을 줄 수도 있다."
    ]

essays : List Essay
essays =
    [humbleMind]