module Projects exposing (Project, data)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)

type alias Project =
  { category    : String
  , year        : Int
  , title       : String
  , url         : Maybe String
  , role        : String
  , tags        : List String
  , description : Maybe String
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
    |> optional "description" (nullable string) Nothing

loadProjects : String -> List Project
loadProjects str =
  case (decodeString (list projectDecoder) str) of
    Ok xs -> xs
    Err _ -> []

data =
  [ Project "work" 2018 "프로토파이 기업용 서버 백엔드 개발" Nothing "외주개발" ["Clojure", "Ring", "Postgres", "Docker", "AWS"] Nothing
  , Project "work" 2018 "N사 협업플랫폼용 CardDAV 서버" Nothing "외주개발" ["Java", "Jetty", "Mustache"] Nothing
  , Project "work" 2017 "N사 협업플랫폼용 LDAP 서버" Nothing "외주개발" ["Java", "Netty", "Spring Boot"] Nothing
  , Project "work" 2017 "N사 협업플랫폼용 주소록 API 서버" Nothing "외주개발" ["Java", "Spring Boot", "JPA", "MySQL"] Nothing
  , Project "work" 2016 "N사 협업플랫폼용 CalDAV 서버" Nothing "외주개발" ["Java", "Spring Boot"] Nothing
  , Project "work" 2015 "N사 협업플랫폼용 메시징 서버" Nothing "외주개발" ["Java", "Akka"] Nothing
  , Project "work" 2015 "N사 협업플랫폼용 SMTP 서버" Nothing "외주개발" ["Java", "Netty", "Tape"] Nothing
  , Project "work" 2014 "Daum Tomcat/Node PaaS 시스템 구축" Nothing "팀장" ["Java", "Node", "Ruby"] Nothing
  , Project "work" 2013 "Daum 사내 Rest API 접근 DNS 시스템 (애조로) 구축" Nothing "팀장" ["팀리딩", "기술영업"] Nothing
  , Project "work" 2013 "Daum Redis PaaS 시스템 구축" Nothing "팀장" ["팀리딩", "기술영업"] Nothing
  , Project "work" 2012 "Daum 사내 Git 저장소 시스템 구축 및 운영" Nothing "팀원" ["Ruby", "Sinatra", "OpenSSH", "Git", "SQLite"] Nothing
  , Project "work" 2012 "Daum 사내 실험 클라우드 플랫폼 구축" Nothing "팀원" ["Ruby", "CloudFoundry"] Nothing
  , Project "work" 2011 "Daum 한메일 ActiveSync 게이트웨이 서버 개발" Nothing "CTO스태프" ["Ruby", "Sinatra", "Redis"] Nothing
  , Project "work" 2010 "Daum 클라우드 파일 동기화 프로토콜 디자인 및 SDK 개발" Nothing "CTO스태프" ["Java", "SDK"] Nothing
  , Project "work" 2010 "Daum 마이피플 네트워크 아키텍쳐 설계 및 초기개발" Nothing "TFT" ["Objective-C", "C"] Nothing
  , Project "work" 2007 "Daum 캘린더 서비스 개발 및 리딩"
    (Just "https://medium.com/happyprogrammer-in-jeju/다음-캘린더-서비스의-비하인드-스토리-ec0faac67f05")
    "TFT장" ["Ruby", "Rails", "MySQL"] Nothing
  , Project "work" 2006 "Daum 카페 채팅 서비스 부하분산 서버 개발" Nothing "팀원" ["C", "PThread"] Nothing
  , Project "work" 2005 "Daum 일본, 개인홈 서비스 개발 및 운영" Nothing "팀장" ["Java", "Spring", "MySQL"] Nothing
  , Project "work" 2004 "Daum 일본, 커뮤니티 서비스 개발 및 운영" Nothing "팀원" ["Java", "Velocity", "MySQL"] Nothing
  , Project "work" 2003 "Daum 플래닛 개인홈 서비스 개발 및 운영" Nothing "팀원" ["Java", "Struts", "MySQL"] Nothing
  , Project "work" 2003 "Daum 카페 한줄 게시판, 투표판 개발" Nothing "팀원" ["Java", "Servlet", "FreeMarker"] Nothing

  , Project "hobby" 2017 "스타웍스 - 스타벅스 WiFi 자동연결 macOS 애플리케이션과 개발기" Nothing "개인" ["Swift"] Nothing
  , Project "hobby" 2016 "http://한글코딩.org/ - 한글로 코딩하자"
    (Just "http://한글코딩.org/") "개인" ["Clojure"]
    (Just "변수, 함수, 객체 이름 지을 때, 콩글리시 영작 그만하고, 한글로 코딩하자는 주장을 담은 웹사이트 오픈")
  , Project "hobby" 2014 "AewolInputMethod - macOS용 한글 입력기 개발"
    (Just "https://medium.com/happyprogrammer-in-jeju/dvorak과-한글-입력기-개발-8940bc4714a1")
    "개인" ["Objective-C", "C"] (Just "Dvorak 자판과 한글 두벌식 자판을 함께 쓰기 편한 macOS용 한글 입력기")
  , Project "hobby" 2010 "귀여운 우주선 게임, xkobo for macOS"
    (Just "https://github.com/hatemogi/xkobo")
    "개인" ["GNU C", "X Window System"] (Just "Dvorak 자판과 한글 두벌식 자판을 함께 쓰기 편한 macOS용 한글 입력기")
  , Project "hobby" 1998 "귀여운 우주선 게임, xkobo for Win32" Nothing
    "개인" ["Delphi", "Win32"] (Just "X윈도우용 오픈소스 게임을 MS윈도용으로 포팅")
  , Project "hobby" 1995 "3인용 테트리스 게임"
    (Just "http://blog.naver.com/PostView.nhn?blogId=taksangs&logNo=60050324463")
    "개인" ["Borland Pascal", "Assembly", "MS-DOS"] (Just "직접 개발한 VESA 그래픽 라이브러리를 이용한 게임 개발")

  , Project "talk" 2017 "한글 코딩 도구 비지니스 피칭" Nothing "개인" ["Clojure"] Nothing
  , Project "talk" 2016 "PyCon 라이트닝토크 - 한글코딩 5분 발표"
    (Just "https://youtu.be/46UkzB-3z3Y")
    "개인" ["Python", "Clojure"]
    (Just "[발표후기](https://medium.com/happyprogrammer-in-jeju/파이콘-2016-라이트닝-토크-발표-후기-763135a2a623")
  , Project "talk" 2013 "Daum DevOn 컨퍼런스 - 사내 Git 저장소 개발사례"
    (Just "https://www.slideshare.net/hatemogi/devon2013-git")
    "개인" [] Nothing

  , Project "번역" 2000 "유의미 버전 SemVer 한글 번역"
    (Just "https://semver.org/lang/kr") "개인" [] Nothing
  , Project "번역" 2000 "클로저 선문답 - Clojure Koans 한글 번역"
    (Just "https://clojurekoans.hatemogi.com") "개인" [] Nothing
  , Project "번역" 2000 "Ring - 클로저 웹서버 인터페이스 스펙 및 라이브러리 문서 번역"
    (Just "https://github.com/hatemogi/ring/wiki") "개인" [] Nothing
  ]
