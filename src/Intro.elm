module Intro exposing (Section, data)


type alias Section =
    { title : String
    , timeline : Maybe String
    , url : Maybe String
    , description : String
    }


data : List Section
data =
    [ Section ""
        Nothing
        Nothing
        """소프트웨어 **프로그래머**. 어려서 재미삼아 프로그래밍에 빠져든 이래 개발을 취미이자
       직업으로 삼았습니다. 모 IT기업에서 백엔드 개발자로 일하고 있습니다.
       오랜 기간 명령형 OOP로 개발하다가, 함수형 프로그래밍에 매료되어,
       Clojure, Haskell, Scala 같은 함수형 프로그래밍 언어를 공부하고 있습니다."""
    , Section "모 IT기업"
        (Just "2019-현재")
        Nothing
        """경기도 소재 모 IT기업에서 백엔드 개발자로 일하고 있습니다. Scala로 백엔드 서버를 구축하고 있습니다.
             혹시나 제 개인적 발언이 회사 입장에서 불편하지 않도록, 사명은 밝히지 않고 있습니다."""
    , Section "NHN"
        (Just "2017-2019")
        (Just "https://www.nhn.com/")
        """NHN Dooray개발실에서 메신저 백엔드 개발을 담당하며, Akka로 메시징 서버를 개발 운영하고, Kotlin으로 웹서비스를
             개발하였습니다. """
    , Section "오후코드 프리랜서"
        (Just "2015-2017")
        (Just "http://ohucode.com/")
        """개인 소프트웨어 개발사 대표로 외주계약 개발자로 일하며, 두 주요 고객사를
             위한 서버 소프트웨어를 개발해 납품했습니다."""
    , Section "카카오"
        (Just "2004-2015")
        (Just "https://kakaocorp.com")
        """지금은 카카오가 된 다음커뮤니케이션에서 카페, 플래닛, 캘린더, 마이피플등의 서비스 개발에
       참여했고, 간혹 웹 프론트엔드나 iOS앱 개발도 했지만, 대부분은 Java와 Ruby로
       백엔드 웹서비스를 개발했습니다. """
    , Section "반갑습니다"
        Nothing
        Nothing
        """여기는 제 개인을 다른분들께 소개드리는 공간이자, 제가 이따금 되돌아 볼 기록을 남겨놓는 웹사이트입니다.
       제가 소속된 단체나 지인들과 무관한 저 홀로 개인의 생각들이 널려있으니 너그러이 봐주시기 바랍니다."""
    ]
