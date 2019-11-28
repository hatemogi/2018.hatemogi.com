module Intro exposing (Section, data)

type alias Section =
  { title       : String
  , url         : Maybe String
  , description : String
  }

data : List Section
data =
  [ Section "" Nothing
    """소프트웨어 **프로그래머**. 어려서 재미삼아 프로그래밍에 빠져든 이래 개발을 취미이자
       직업으로 삼았습니다. 홍익대에서 컴퓨터공학을 전공하고,
       다음커뮤니케이션(현재 카카오)에서 클라우드기술팀 팀장을 거치며 만 10년 정도 근무한 뒤,
       잠시 프리랜서로 일하다, 다시 판교의 대기업에 입사하여 백엔드 개발을 담당하고 있습니다."""
  , Section "다음커뮤니케이션" Nothing
    """다음커뮤니케이션에서는 카페, 플래닛, 캘린더, 마이피플등의 서비스 개발에
       참여했고, 간혹 웹 프론트엔드나 iOS앱 개발도 했지만, 대부분은 Java와 Ruby로
       백엔드 웹서비스를 개발했습니다. """
  , Section "오후코드 대표" Nothing
    """개인 소프트웨어 개발사 대표로 외주계약 개발자로 일하며, 두 주요 고객사를
       위한 서버 소프트웨어를 개발해 납품했습니다."""
  , Section "판교의 직장인" Nothing
    """다시 대기업의 직원이 되어, Java, Kotlin으로 웹서비스 백엔드 개발을 담당하고 있습니다.
       혹시나 제 개인적 발언이 회사 입장에서 불편하지 않도록, 사명은 밝히지 않고 있습니다."""
  , Section "반갑습니다" Nothing
    """여기는 제 개인을 다른분들께 소개드리는 공간이자, 제가 이따금 되돌아 볼 기록을 남겨놓는 웹사이트입니다.
       제가 소속된 단체나 지인들과 무관한 저 홀로 개인의 생각들이 널려있으니 너그러이 봐주시기 바랍니다."""
  ]
