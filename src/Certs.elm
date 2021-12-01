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
    [ Certificate "Functional Programming Principles in Scala"
        "2019/12"
        "functional-programming-principles.png"
        "https://www.coursera.org/account/accomplishments/verify/G8484AJVKD38"
        [ "스칼라", "함수형", "coursera" ]
        """스칼라 언어로 함수형 프로그래밍의 원리를 알려주는 수업입니다.
        명령형 프로그래밍과는 접근하는 출발점이 달라서 인상적이었습니다.
        프로그램 코드를 기준으로, 증명(!)을 시도하는 것도 놀라웠구요.
        재귀 호출 훈련을 받을 수 있습니다."""
    , Certificate "Functional Program Design in Scala"
        "2019/12"
        "functional-program-design.png"
        "https://www.coursera.org/account/accomplishments/verify/C46AZ4X9TD8H"
        [ "스칼라", "함수형", "coursera" ]
        """스칼라 언어로 함수형 프로그래밍을 조금더 깊이있게 다루는 수업입니다. for-comprehension도
        본격적으로 활용하고, 모나드에 대해서도 알려줍니다. 비록 아직도 모나드를 잘 모르겠지만,
        어쨌건 pure와 flatMap이 가능한 무언가라고 여겨봅시다."""
    , Certificate "Big Data Analysis with Scala and Spark"
        "2019/12"
        "bigdata-analysis.png"
        "https://www.coursera.org/account/accomplishments/verify/9ZYD74J2N5QB"
        [ "스칼라", "함수형", "Spark", "빅데이터", "coursera" ]
        """대용량 데이터 분석을 도와주는 아파치 스파크에 대한 수업입니다. 스파크를 다루는 기초부터
        활용까지 상세하게 알려줍니다. RDD가 무엇인지, 어떻게 효과적으로 활용해야 하는지 알 수 있게 됩니다."""
    , Certificate "Kotlin for Java Developers"
        "2019/03"
        "kotlin-for-java-developers.png"
        "https://www.coursera.org/account/accomplishments/verify/YW847W7GCM88"
        [ "코틀린", "coursera" ]
        """Kotlin언어를 개발한 JetBrain사에서 직접 만든 수업입니다. 자바 개발자를 대상으로 코틀린을 쉽게
        배울 수 있도록 친절하게 설명해줍니다. 안드로이드 개발의 표준언어로 채택되었기에 관심을 갖고
        공부해보았습니다. 자바와 1:1 대응 구현이 가능하면서 매우 편리한 문법 기능이 많이있어서 좋았습니다."""
    , Certificate "Programming Reactive Systems"
        "2020/12"
        "reactive-systems.png"
        "https://courses.edx.org/certificates/2bb6c61caef64f27a35d3f47e086390f"
        [ "반응형", "함수형", "스칼라", "edX" ]
        """동시성 처리가 편리한 액터 모델(actor model)을 구현한 Akka를 써서,
        반응형 프로그래밍을 하는 방법을 알려주는 수업입니다. 반응형 프로그래밍이나,
        Akka를 써서 서비스 개발을 해보실 분들께 추천드리는 수업입니다."""
    , Certificate "Effective Programming in Scala"
        "2021/06"
        "effective-scala.png"
        "https://www.coursera.org/account/accomplishments/verify/YN3K9BC2HKV4"
        ["함수형", "스칼라"]
        """스칼라 3 버전에서 효과적인 프로그래밍을 할 수 있는 기법들을 배울 수 있는 수업입니다."""
    ]
