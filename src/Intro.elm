module Intro exposing (Section, data)


type alias Section =
    { title : String
    , timeline : Maybe String
    , url : Maybe String
    , description : String
    }


data : List Section
data =
    [ Section "Constacts"
        (Just "2022")
        (Just "https://www.constacts.com/")
        """이번엔 하스켈입니다. 하스켈로 로켓 스타트업의 백엔드 시스템을 구축합니다."""
    , Section "LINE+"
        (Just "2020-2022")
        (Just "https://engineering.linecorp.com/ko/")
        """LINE+ 광고플랫폼 MONAD팀 LEAD로 일했습니다. 함수형 Scala로 광고 수익 배분 시스템을 구축해 운영했습니다.
        """
    , Section "NHN"
        (Just "2018-2020")
        (Just "https://www.nhn.com/")
        """NHN Dooray개발실에서 업무용 메신저 서비스 개발을 담당하며, Akka로 메시징 서버를 구축했고,
        Java와 Kotlin으로 API 서버를 개발했습니다. """
    , Section "오후코드"
        (Just "2015-2018")
        (Just "http://ohucode.com/")
        """개인 소프트웨어 개발사 대표로, 두 주요 고객사를 위한 서버 소프트웨어를 개발해 납품했습니다."""
    , Section "카카오"
        (Just "2004-2015")
        (Just "https://kakaocorp.com")
        """지금은 카카오가 된 다음커뮤니케이션에서 카페, 플래닛, 캘린더, 마이피플등의 서비스 개발에
       참여했고, 간혹 웹 프론트엔드나 iOS앱 개발도 했지만, 대부분은 Java와 Ruby로
       백엔드 웹서비스를 개발했습니다. 초반에 1년 반 정도 일본 도쿄 지사에서 근무한 경험이 있습니다."""
    , Section "반갑습니다"
        Nothing
        Nothing
        """여기는 제 개인을 다른분들께 소개드리는 공간이자, 제가 이따금 되돌아 볼 기록을 남겨놓는 웹사이트입니다.
       제가 소속된 단체나 지인들과 무관한 저 홀로 개인의 생각들이 널려있으니 너그러이 봐주시기 바랍니다."""
    ]
