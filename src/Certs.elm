module Certs exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Certificate =
    { title : String
    , date : String
    , image : String
    , url : String
    , tags : List String
    , descrition : String
    }


data : List Certificate
data =
    [ Certificate
        "Functional Programming Principles in Scala"
        "2019/12"
        "functional-programming-principles.png"
        "https://www.coursera.org/account/accomplishments/verify/G8484AJVKD38"
        [ "스칼라", "함수형", "coursera" ]
        """스칼라 언어로 함수형 프로그래밍의 원리를 알려주는 수업입니다. 
    명령형 프로그래밍과는 접근하는 출발점이 달라서 인상적이었습니다. 
    프로그램 코드를 기준으로, 증명(!)을 시도하는 것도 놀라웠구요. 
    재귀 호출 훈련을 받을 수 있습니다."""
    ]
