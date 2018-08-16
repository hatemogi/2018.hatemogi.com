module Projects exposing (Project, data, tags)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Set

type alias Project =
  { category    : String
  , year        : Int
  , title       : String
  , url         : Maybe String
  , role        : String
  , tags        : List String
  , description : String
  }

projectDecoder : Decoder Project
projectDecoder =
  decode Project
    |> required "category" string
    |> required "year" int
    |> required "title" string
    |> optional "url" (nullable string) Nothing
    |> required "role" string
    |> required "tags" (list string)
    |> required "description" string

loadProjects : String -> List Project
loadProjects str =
  case (decodeString (list projectDecoder) str) of
    Ok xs -> xs
    Err _ -> []

data =
  [ Project "업무" 2018 "ProtoPie 엔터프라이즈 서버 백엔드 개발" Nothing "외주개발" ["Clojure", "Ring", "Postgres", "Docker", "AWS"]
    """UX 디자이너가 코드 작성 없이 모바일앱 프로토타이핑할 수 있는 데스크탑 애플리케이션인 [ProtoPie](https://protopie.io)의
       기업용 클라우드 시스템 백엔드 개발 담당. ProtoPie의 고객사 자체 인프라 리눅스 시스템에 Docker Compose 이미지셋을 배포에서 자체
       백엔드 시스템 운영할 수 있게 개발했으며, 현재 국내 대기업 세 곳과 납품계약되었고, 그 중 두 곳에 설치 운영 중입니다. """
  , Project "업무" 2018 "N사 협업플랫폼용 CardDAV 서버" Nothing "외주개발" ["Java", "Jetty", "Mustache"]
    """고객사에서 개발 및 운영중인 시스템을 위한 [CardDAV](https://en.wikipedia.org/wiki/CardDAV) 게이트웨이 서버를 개발해 납품.
       주소록 서비스를 위한 표준 프로토콜인 CardDAV를 서버를 Java8에 Jetty를 써서 구현했습니다."""
  , Project "업무" 2017 "N사 협업플랫폼용 LDAP 서버" Nothing "외주개발" ["Java", "Netty", "Spring Boot"]
    """고객사 시스템에 포함되는 [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol)
       게이트웨이 서버를 개발해 납품. Java8에 Netty를 써서 LDAP 프로토콜 통신하는 서버 구현했습니다."""
  , Project "업무" 2017 "N사 협업플랫폼용 주소록 API 서버" Nothing "외주개발" ["Java", "Spring Boot", "JPA", "MySQL"]
    """고객사 시스템에 포함되는 주소록 백엔드 API서버 개발. MySQL 데이터베이스에 JPA로 접근해서 REST API 서비스를 제공하는
       자바 스프링부트 애플리케이션을 개발해서 납품했습니다."""
  , Project "업무" 2016 "N사 협업플랫폼용 CalDAV 서버" Nothing "외주개발" ["Java", "Spring Boot"]
    """고객사 시스템에 통합되는 캘린더 표준 프로토콜 [CalDAV](https://en.wikipedia.org/wiki/CalDAV) 지원 서버를
       자바 스프링 부트로 개발해서 납품했습니다."""
  , Project "업무" 2015 "N사 협업플랫폼용 메시징 서버" Nothing "외주개발" ["Java", "Akka"]
    """고객사 시스템에 채팅 서비스 용도로 활용하는 메시징 서버를 자바에 Akka를 써서 비동기 서비스로 개발해서 납품했습니다."""
  , Project "업무" 2015 "N사 협업플랫폼용 SMTP 서버" Nothing "외주개발" ["Java", "Netty", "Tape"]
    """고객사 시스템에 메일 발송 기능을 위한 SMTP 서버를 자바에 Netty로 개발해서 납품. SMTP 프로토콜 성공 응답한 메일에 대해
       완전한 발송 처리를 위해 고객사 기능 명세대로 Tape 파일 큐 라이브러리를 사용해서 구현했습니다."""
  , Project "업무" 2014 "Daum Tomcat/Node PaaS 시스템 구축 리딩" Nothing "팀장" ["Java", "Node", "Ruby"]
    """Java Tomcat 웹서비스와 Node.js서비스를 손쉽게 자동 배포하고 운영할 수 있는 클라우드 PaaS 시스템 구축을 리딩하고,
       사내 타팀 이용을 장려하는 기술영업."""
  , Project "업무" 2013 "Daum 사내 Rest API 접근 DNS 시스템 (애조로) 구축 리딩" Nothing "팀장" ["팀리딩", "기술영업"]
    """사내 DNS를 직원 계정으로 접근해서 등록하고, 수정할 수 있는 웹서비스와 DNS서버 시스템을 기획하고 개발 리딩후 공개해서,
       전사 직원이 각종 서비스 개발 테스트마다 고통받던 hosts파일 수정 작업으로부터 해방되었습니다. """
  , Project "업무" 2013 "Daum Redis PaaS 시스템 구축 리딩" Nothing "팀장" ["팀리딩", "기술영업"]
    """메모리 기반 단순한 데이터베이스 서버인 Redis를 사내 각 서비스에서 손쉽게 사용할 수 있도록 PaaS 클라우드 서비스로 제공하는 기획하고 리딩.
       당시 캐싱 목적으로는 일반적으로 Java EHCache나 [Memcached](https://en.wikipedia.org/wiki/Memcached)를 쓰던 추세였는데, 이들은 캐시 처리를 할 때,
       발생하던 잦은 invalidation으로 인해 캐시 hit ratio가 떨어져서 DB 부하가 증가하던 상황을 Redis의 List 캐시를 적용하도록 안내해서
       전체 시스템 안정성 향상에 도움이 되었습니다.
       일반적으로 새로운 좋은 도구나 서비스가 있더라도, 실 개발팀 입장에서는 새로운 서비스를 전환 도입할 때 운영 경험이 아직 없기에
       알 수 없는 장애 상황이 미리 두려워서 신규 도입에 보수적일 수 밖에 없다는 점을 공략하기 위해, 공통 플랫폼을 구축하고 운영을 대행해주는 방식으로
       전사 전파에 실효를 거두어, 카페 서비스를 비롯한 여러 실 서비스에 적용 운영되었습니다.
       사실 Redis서버는 매우 안정적이어서 대행 운영에 큰 부담이 없었고, 이용 개발팀 입장에서는 운영 부담만 없으면, 개발 부담은 아주 가벼이 여길 수
       있기에 널리 이용되었습니다. 이 서비스의 실효와 안정성이 입소문을 타고 여러 팀에 알려져서 우리팀이 공개하는 타 서비스의 전파에도 긍정적 영향을 끼쳤고,
       전사입장에서는 전체 서비스 안정적과 처리속도 향상 효과를 얻었습니다.
       """
  , Project "업무" 2012 "Daum 사내 Git 저장소 시스템 구축 및 운영" Nothing "팀원" ["Ruby", "Sinatra", "OpenSSH", "Git", "SQLite"]
    """전사 개발자들이 자율적으로 편리하게 쓸 수 있는 Git 저장소 시스템을 구축해서 운영.
       Ruby에 Sinatra를 써서 웹서비스를 개발했습니다. Git 서비스 인증을 위해 OpenSSH 소스를 약간 패치했고, 저장소 관련 데이터베이스는
       SQLite로 가볍게 가져갔습니다. Git 시스템 자체가 워낙 폭발적인 인기를 얻었기에, 자연스럽게 제가 만든 서비스도 사내 개발자들에게 널리
       사용됐으며, 2~3년 성공적으로 운영되다가, 카카오 합병 이후 카카오가 사용하던 GitHub Enterprise로 전환되었습니다."""
  , Project "업무" 2012 "Daum 사내 실험 클라우드 플랫폼 구축" Nothing "팀원" ["Ruby", "CloudFoundry"]
    """사내 실험적 클라우드 플랫폼을 오픈소스 CloudFoundry 제품을 이용해서 구축해서 제공. 개발 테스트 서비스를 손쉽게 배포해 운영
       테스트해볼 수 있도록 만들었습니다."""
  , Project "업무" 2011 "Daum 한메일 ActiveSync 게이트웨이 서버 개발" Nothing "CTO스태프" ["Ruby", "Sinatra", "Redis"]
    """한메일 서비스를 안드로이드 스마트폰에서 손쉽게 연결해 쓸 수 있도록 ActiveSync 프로토콜을 지원하게끔 게이트웨이 서버를 개발."""
  , Project "업무" 2010 "Daum 클라우드 파일 동기화 프로토콜 디자인 및 SDK 개발" Nothing "CTO스태프" ["Java", "SDK"]
    """Dropbox같은 서비스인 Daum 클라우드에서 파일 동기화를 위해 사용하는 프로토콜을 설계하고 자바 SDK를 개발해서 제공. 기존 파일과
       새로 올리는 파일의 차이점을 추려서 송수신하도록 하여 네트워크 비용을 줄이게끔 설계해서 제공했습니다."""
  , Project "업무" 2010 "Daum 마이피플 네트워크 아키텍쳐 설계 및 초기개발" Nothing "TFT" ["Objective-C", "C"]
    """MyPeople서비스를 초기 개발하는 TFT에서 네트워크 아키텍쳐를 설계하고, 메시징 서버 연동을 비롯한 클라이언트 개발에도 참여했습니다. """
  , Project "업무" 2007 "Daum 캘린더 서비스 개발 및 리딩"
    (Just "https://medium.com/happyprogrammer-in-jeju/다음-캘린더-서비스의-비하인드-스토리-ec0faac67f05")
    "TFT장" ["팀리딩", "Ruby", "Rails", "MySQL"]
    """"""
  , Project "업무" 2006 "Daum 카페 채팅 서비스 부하분산 서버 개발" Nothing "팀원" ["C", "PThread"]
    """"""
  , Project "업무" 2005 "Daum 일본, 개인홈 서비스 개발 및 운영" Nothing "팀장" ["Java", "Spring", "MySQL"]
    """"""
  , Project "업무" 2004 "Daum 일본, 커뮤니티 서비스 개발 및 운영" Nothing "팀원" ["Java", "Velocity", "MySQL"]
    """"""
  , Project "업무" 2003 "Daum 플래닛 개인홈 서비스 개발 및 운영" Nothing "팀원" ["Java", "Struts", "MySQL"]
    """"""
  , Project "업무" 2003 "Daum 카페 한줄 게시판, 투표판 개발" Nothing "팀원" ["Java", "Servlet", "FreeMarker"]
    """"""
  , Project "취미" 2017 "스타웍스 - 스타벅스 WiFi 자동연결 macOS 애플리케이션과 개발기" Nothing "개인" ["Swift"]
    """"""
  , Project "취미" 2016 "한글코딩.org 기획 공개"
    (Just "http://한글코딩.org/") "개인" ["Clojure"]
    "변수, 함수, 객체 이름 지을 때, 콩글리시 영작 그만하고, 한글로 코딩하자는 주장을 담은 웹사이트 오픈"
  , Project "취미" 2014 "AewolInputMethod - macOS용 한글 입력기 개발"
    (Just "https://medium.com/happyprogrammer-in-jeju/dvorak과-한글-입력기-개발-8940bc4714a1")
    "개인" ["Objective-C", "C"]
    "Dvorak 자판과 한글 두벌식 자판을 함께 쓰기 편한 macOS용 한글 입력기"
  , Project "취미" 2010 "귀여운 우주선 게임, xkobo for macOS"
    (Just "https://github.com/hatemogi/xkobo")
    "개인" ["GNU C", "X Window System"]
    "UNIX용 아케이드 게임을 macOS에서도 실행되게끔 수정해서 오픈소스 공개"
  , Project "취미" 1998 "귀여운 우주선 게임, xkobo for Win32" Nothing
    "개인" ["Delphi", "Win32"]
    "대학시절 학과 동호회방에서 유행하던 UNIX X Window용 아케이드 게임을 윈도우용 Delphi로 재개발(포팅)해서 공개했습니다."
  , Project "취미" 1995 "3인용 테트리스 게임"
    (Just "http://blog.naver.com/PostView.nhn?blogId=taksangs&logNo=60050324463")
    "개인" ["Borland Pascal", "Assembly", "MS-DOS"]
    """직접 개발한 VESA 한글 그래픽 라이브러리를 이용한 게임 개발"""
  , Project "발표" 2017 "한글 코딩 도구 비지니스 피칭" Nothing "개인" ["Clojure"]
    """"""
  , Project "발표" 2016 "PyCon 라이트닝토크 - 한글코딩 5분 발표"
    (Just "https://youtu.be/46UkzB-3z3Y") "개인" ["Python", "Clojure"]
    "[발표후기](https://medium.com/happyprogrammer-in-jeju/파이콘-2016-라이트닝-토크-발표-후기-763135a2a623)"
  , Project "발표" 2013 "Daum DevOn 컨퍼런스 - 사내 Git 저장소 개발사례"
    (Just "https://www.slideshare.net/hatemogi/devon2013-git") "개인" []
    """"""
  , Project "번역" 2000 "유의미 버전 SemVer 한글 번역"
    (Just "https://semver.org/lang/ko") "개인" []
    """"""
  , Project "번역" 2000 "클로저 선문답 - Clojure Koans 한글 번역"
    (Just "https://clojurekoans.hatemogi.com") "개인" []
    """"""
  , Project "번역" 2000 "Ring - 클로저 웹서버 인터페이스 스펙 및 라이브러리 문서 번역"
    (Just "https://github.com/hatemogi/ring/wiki") "개인" []
    """"""
  ]

tags = data
  |> List.concatMap .tags
  |> List.map String.toLower
  |> Set.fromList
  |> Set.toList
