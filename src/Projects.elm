module Projects exposing (Project, data, tags)

import Set


type alias Project =
    { category : String
    , year : Int
    , title : String
    , url : Maybe String
    , role : String
    , tags : List String
    , description : String
    }


data =
    [ Project "업무"
        2019
        "메신저 메시징 서버와 웹서비스 개발"
        Nothing
        "수석"
        [ "Java", "Kotlin", "Ktor", "Exposed" ]
        """사내외에서 운영하고 있는 메신저 서비스의 메시징 서버를 Akka로 개발하여 운영하며, 자바와 코틀린으로 백엔드 웹서비스를
        개발 운영하고 있습니다."""

    , Project "취미"
        2019
        "당신의 타자 실력을 알려주는 웹 앱"
        (Just "https://medium.com/happyprogrammer-in-jeju/7e0c0e44b37c")
        "개인프로젝트"
        [ "TypeScript", "Vue", "HTML5 Canvas", "한글" ]
        """한 달의 여유시간 동안 뭘 할까 고민하다가 재미삼아 타자 연습 웹 앱을 만들었습니다. 초성, 중성, 종성 자소별 색상을 따로
        보이려 한글 비트맵 폰트를 그린 이야기와 입력 오토마타를 구현한 이야기도 정리해 두었습니다. 만든 결과물은
        <http://type.hatemogi.com/>에서 볼 수 있습니다."""
    , Project "업무"
        2018
        "ProtoPie 엔터프라이즈 서버 백엔드 개발"
        Nothing
        "외주개발"
        [ "Clojure", "Ring", "Postgres", "Docker", "AWS" ]
        """UX 디자이너가 코드 작성 없이 모바일앱 프로토타이핑할 수 있는 데스크탑 애플리케이션인 [ProtoPie](https://protopie.io)의
       기업용 클라우드 시스템 백엔드 개발 담당. ProtoPie의 고객사 자체 인프라 리눅스 시스템에 Docker Compose 이미지셋을 배포에서 자체
       백엔드 시스템 운영할 수 있게 개발했으며, 현재 국내 대기업 세 곳과 납품계약되었고, 그 중 두 곳에 설치 운영 중입니다. """
    , Project "업무"
        2018
        "N사 협업플랫폼용 CardDAV 서버"
        Nothing
        "외주개발"
        [ "Java", "Jetty", "Mustache" ]
        """고객사에서 개발 및 운영중인 시스템을 위한 [CardDAV](https://en.wikipedia.org/wiki/CardDAV) 게이트웨이 서버를 개발해 납품.
       주소록 서비스를 위한 표준 프로토콜인 CardDAV를 서버를 Java8에 Jetty를 써서 구현했습니다."""
    , Project "업무"
        2017
        "N사 협업플랫폼용 LDAP 서버"
        Nothing
        "외주개발"
        [ "Java", "Netty", "Spring Boot" ]
        """고객사 시스템에 포함되는 [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol)
       게이트웨이 서버를 개발해 납품. Java8에 Netty를 써서 LDAP 프로토콜 통신하는 서버 구현했습니다."""
    , Project "업무"
        2017
        "N사 협업플랫폼용 주소록 API 서버"
        Nothing
        "외주개발"
        [ "Java", "Spring Boot", "JPA", "MySQL" ]
        """고객사 시스템에 포함되는 주소록 백엔드 API서버 개발. MySQL 데이터베이스에 JPA로 접근해서 REST API 서비스를 제공하는
       자바 스프링부트 애플리케이션을 개발해서 납품했습니다."""
    , Project "업무"
        2016
        "N사 협업플랫폼용 CalDAV 서버"
        Nothing
        "외주개발"
        [ "Java", "Spring Boot" ]
        """고객사 시스템에 통합되는 캘린더 표준 프로토콜 [CalDAV](https://en.wikipedia.org/wiki/CalDAV) 지원 서버를
       자바 스프링 부트로 개발해서 납품했습니다."""
    , Project "업무"
        2015
        "N사 협업플랫폼용 메시징 서버"
        Nothing
        "외주개발"
        [ "Java", "Akka" ]
        """고객사 시스템에 채팅 서비스 용도로 활용하는 메시징 서버를 자바에 Akka를 써서 비동기 서비스로 개발해서 납품했습니다."""
    , Project "업무"
        2015
        "N사 협업플랫폼용 SMTP 서버"
        Nothing
        "외주개발"
        [ "Java", "Netty", "Tape" ]
        """고객사 시스템에 메일 발송 기능을 위한 SMTP 서버를 자바에 Netty로 개발해서 납품. SMTP 프로토콜 성공 응답한 메일에 대해
       완전한 발송 처리를 위해 고객사 기능 명세대로 Tape 파일 큐 라이브러리를 사용해서 구현했습니다."""
    , Project "업무"
        2014
        "Daum Tomcat/Node PaaS 시스템 구축 리딩"
        Nothing
        "팀장"
        [ "Java", "Node", "Ruby" ]
        """Java Tomcat 웹서비스와 Node.js서비스를 손쉽게 자동 배포하고 운영할 수 있는 클라우드 PaaS 시스템 구축을 리딩하고,
       사내 타팀 이용을 장려하는 기술영업."""
    , Project "업무"
        2013
        "Daum 사내 Rest API 접근 DNS 시스템 (애조로) 구축 리딩"
        Nothing
        "팀장"
        [ "팀리딩", "기술영업" ]
        """사내 DNS를 직원 계정으로 접근해서 등록하고, 수정할 수 있는 웹서비스와 DNS서버 시스템을 기획하고 개발 리딩후 공개해서,
       전사 직원이 각종 서비스 개발 테스트마다 고통받던 hosts파일 수정 작업으로부터 해방되었습니다. """
    , Project "업무"
        2013
        "Daum Redis PaaS 시스템 구축 리딩"
        Nothing
        "팀장"
        [ "팀리딩", "기술영업" ]
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
    , Project "업무"
        2012
        "Daum 사내 Git 저장소 시스템 구축 및 운영"
        Nothing
        "팀원"
        [ "Ruby", "Sinatra", "OpenSSH", "Git", "SQLite" ]
        """전사 개발자들이 자율적으로 편리하게 쓸 수 있는 Git 저장소 시스템을 구축해서 운영.
       Ruby에 Sinatra를 써서 웹서비스를 개발했습니다. Git 서비스 인증을 위해 OpenSSH 소스를 약간 패치했고, 저장소 관련 데이터베이스는
       SQLite로 가볍게 가져갔습니다. Git 시스템 자체가 워낙 폭발적인 인기를 얻었기에, 자연스럽게 제가 만든 서비스도 사내 개발자들에게 널리
       사용됐으며, 2~3년 성공적으로 운영되다가, 카카오 합병 이후 카카오가 사용하던 GitHub Enterprise로 전환되었습니다."""
    , Project "업무"
        2012
        "Daum 사내 실험 클라우드 플랫폼 구축"
        Nothing
        "팀원"
        [ "Ruby", "CloudFoundry" ]
        """사내 실험적 클라우드 플랫폼을 오픈소스 CloudFoundry 제품을 이용해서 구축해서 제공. 개발 테스트 서비스를 손쉽게 배포해 운영
       테스트해볼 수 있도록 만들었습니다."""
    , Project "업무"
        2011
        "Daum 한메일 ActiveSync 게이트웨이 서버 개발"
        Nothing
        "CTO스태프"
        [ "Ruby", "Sinatra", "Redis" ]
        """한메일 서비스를 안드로이드 스마트폰에서 손쉽게 연결해 쓸 수 있도록 ActiveSync 프로토콜을 지원하게끔 게이트웨이 서버를 개발."""
    , Project "업무"
        2010
        "Daum 클라우드 파일 동기화 프로토콜 디자인 및 SDK 개발"
        Nothing
        "CTO스태프"
        [ "Java", "SDK" ]
        """Dropbox같은 서비스인 Daum 클라우드에서 파일 동기화를 위해 사용하는 프로토콜을 설계하고 자바 SDK를 개발해서 제공. 기존 파일과
       새로 올리는 파일의 차이점을 추려서 송수신하도록 하여 네트워크 비용을 줄이게끔 설계해서 제공했습니다."""
    , Project "업무"
        2010
        "Daum 마이피플 네트워크 아키텍쳐 설계 및 초기개발"
        Nothing
        "TFT"
        [ "Objective-C", "C" ]
        """MyPeople서비스를 초기 개발하는 TFT에서 네트워크 아키텍쳐를 설계하고, 메시징 서버 연동을 비롯한 클라이언트 개발에도 참여했습니다. """
    , Project "업무"
        2007
        "Daum 캘린더 서비스 개발 및 리딩"
        (Just "https://medium.com/happyprogrammer-in-jeju/다음-캘린더-서비스의-비하인드-스토리-ec0faac67f05")
        "TFT장"
        [ "팀리딩", "Ruby", "Rails", "MySQL" ]
        """다음 캘린더 서비스의 초기 기획단계부터 안정화 단계까지 개발에 참여 및 TFT 리딩. Ruby On Rails로 백엔드 서비스를 구현했고,
       당시 유행하던 웹 2.0 서비스를 한메일 익스프레스와 함께 다음 최초로 실서비스 도입한 사례. 카카오 합병에 이어 서비스 종료에
       즈음해 작성해 공개한 글 (제목 링크 참조)도 꽤 호응을 얻었습니다."""
    , Project "업무"
        2006
        "Daum 카페 채팅 서비스 부하분산 서버 개발"
        Nothing
        "팀원"
        [ "C", "PThread" ]
        """다음 카페의 채팅 서비스에 교체 도입되는 채팅서버의 앞단에서 부하 분산을 담당하는 C 서버 개발. 당시 카페 채팅 서비스는
       Java로 구현해 운영했는데, 과도한 트래픽으로 잦은 장애상황이 발생하던 상황이었고, CTO가 C기반 비동기 메시징 서버로 교체를
       결정했고, 저는 그 교체시스템 중에 앞단 로드 밸런서를 개발했습니다. 채팅 서비스의 흐름상 멀티스레드 대비 비동기 처리의
       효과가 극대화되는 특성으로 인해, 기존 36대의 채팅서버를 4대로 줄였고, 장애 빈도를 대폭 낮추었습니다. """
    , Project "업무"
        2005
        "Daum 일본, 개인홈 서비스 개발 및 운영"
        Nothing
        "팀장"
        [ "Java", "Spring", "MySQL" ]
        """다음 재팬 근무시절 개인 홈 서비스 개발 및 유지 보수"""
    , Project "업무"
        2004
        "Daum 일본, 커뮤니티 서비스 개발 및 운영"
        Nothing
        "팀원"
        [ "Java", "Velocity", "MySQL" ]
        """다음 재팬 근무시절 커뮤니티 서비스 유지 보수"""
    , Project "업무"
        2003
        "Daum 플래닛 개인홈 서비스 개발 및 운영"
        Nothing
        "팀원"
        [ "Java", "Struts", "MySQL" ]
        """개인 커뮤니티 서비스인 **Daum 플래닛** 개발에 참여."""
    , Project "업무"
        2003
        "Daum 카페 한줄 게시판, 투표판 개발"
        Nothing
        "팀원"
        [ "Java", "Servlet", "FreeMarker" ]
        """다음 카페 서비스 개발팀 소속으로 서비스 유지보수와 더불어 **한줄 게시판**과 **투표판** 기능 추가 개발.
       당시 다음 카페의 전성기로 **일 3억 PV**를 처리하는 경험을 쌓을 수 있었습니다."""
    , Project "업무"
        2000
        "한국물류정보통신 시스템팀 사원"
        Nothing
        "팀원"
        [ "C", "UNIX", "Python" ]
        """병역특례로 40개월간 한국물류정보통신(현재 KL-Net) 시스템팀에 근무하며, 윈도우NT 시스템 관리, 리눅스 개발장비 관리, CISCO 라우터 관리,
       네트워크 방화벽 관리를 담당했고, EDI 전자문서중계 시스템의 유닉스 C 애플리케이션을 고객사에 수정배포하는 일도 담당했습니다."""
    , Project "취미"
        2017
        "스타웍스 macOS 앱 개발"
        (Just "http://스타웍스.com")
        "개인"
        [ "Swift" ]
        """스타벅스 WiFi 자동연결 macOS 애플리케이션과 개발기를 작성해 공유. 한국 스타벅스에서 맥북프로를 써서 무료 WiFi에 접속할 때
       불편한 동의과정을 자동화해주는 macOS 앱을 만들어 공개했습니다. 스타벅스 기프트카드를 보낼 수 있는 무료 소프트웨어로 공개했고,
       일부 사용자로부터 도합 10여만원 상당의 기프트카드를 받았습니다. Swift로 WebKit엔진을 붙여서 캡티브 네트워크 연결창을 띄워서
       처리해 개발했습니다. [개발기도 미디엄에 연재](https://medium.com/happyprogrammer-in-jeju/스타벅스-연결러-앱-공개-개발-후기-c0c5f88a86e8)해서
       일부 개발자들로부터 좋은 호응을 얻었습니다."""
    , Project "취미"
        2016
        "한글코딩.org 기획 공개"
        (Just "http://한글코딩.org/")
        "개인"
        [ "Clojure" ]
        """변수, 함수, 객체 이름 지을 때, 콩글리시 영작 그만하고, 한글로 코딩하자는 주장을 담은 웹사이트 오픈.
       관련해서 PyCon 2016에서 라이트닝토크도 발표자로 참여했습니다."""
    , Project "취미"
        2014
        "AewolInputMethod - macOS용 한글 입력기 개발"
        (Just "https://github.com/hatemogi/AewolInput")
        "개인"
        [ "Objective-C", "C" ]
        """Dvorak 자판과 한글 두벌식 자판을 함께 쓰기 편한 macOS용 한글 입력기 개발 및 공개. 한글 두벌식 자판과 영문 드보락 자판을
       함께 사용할 때 macOS에서 단축키 입력이 불편해지는 문제를 해결하는 입력기 애플리케이션을 개발해서 공개했습니다.
       한글 입력 오토마타는 기존 오픈소스 라이브러리인 libhangul을 써서 개발했고, 저는 macOS의 IMKit 프레임워크를 사용해서
       애플리케이션으로 만드는 작업을 했습니다.
       [개발한 이야기](https://medium.com/happyprogrammer-in-jeju/dvorak과-한글-입력기-개발-8940bc4714a1)도 적어두었습니다."""
    , Project "취미"
        2010
        "귀여운 우주선 게임, xkobo for macOS"
        (Just "https://github.com/hatemogi/xkobo")
        "개인"
        [ "GNU C", "X Window System" ]
        """UNIX용 아케이드 게임을 macOS에서도 실행되게끔 수정해서 오픈소스 공개. 아쉽게도 현재 macOS는 X 윈도우 시스템이 포함되지 않은채로
       배포되어, 그대로 빌드되지는 않을 것 같습니다."""
    , Project "취미"
        1998
        "귀여운 우주선 게임, xkobo for Win32"
        Nothing
        "개인"
        [ "Delphi", "Win32" ]
        """대학시절 학과 동호회방에서 유행하던 UNIX X Window용 아케이드 게임을 윈도우용 Delphi로 재개발(포팅)해서 공개했습니다. 이 프로젝트로
     저는 X윈도우 시스템과 Win32 시스템에 대한 이해도를 높히며 개발에 몰입할 수 있었고, 학과 동기들은 동호회방에서만 해볼 수 있던 게임을
     각자 집에서도 해볼 수 있게되었습니다."""
    , Project "취미"
        1995
        "3인용 테트리스 게임"
        (Just "http://blog.naver.com/PostView.nhn?blogId=taksangs&logNo=60050324463")
        "개인"
        [ "Borland Pascal", "Assembly", "MS-DOS" ]
        """직접 개발한 VESA 한글 그래픽 라이브러리를 이용한 테트리스 게임 개발. 고등학교 시절에 직접 개발한 한글 그래픽 라이브러리를 이용해
       데모로 테트리스 게임을 만들어 공개했습니다. 배경 이미지와 음악을 변경할 수 있는 확장팩 기능을 넣어 하이텔과 나우누리에 공개했는데,
       제 오리지날 버전도 **월간 마이크로소프트웨어 1995년 5월호** 180p에 소개가 실렸습니다만, 어떤 분이 당시 유행하던 일본만화를 주제로 테마를 입힌 버전이 원판보다
       더 널리 알려져서, 사람들은 "**오 나의 여신님 테트리스**"라고 알고 있는 경우가 있습니다. """
    , Project "취미"
        1992
        "MS-DOS 부팅 잠금 프로그램 개발 - 자물쇠"
        Nothing
        "개인"
        [ "Turbo Pascal", "Assembly", "MS-DOS" ]
        """중학생 때, MS-DOS 부팅 패스워드 인증 시스템 소프트웨어 개발. 당시 IBM호환 PC의 주운영체제는 MS-DOS였는데, 이는 사용자 로그인 과정이 없어서,
       컴퓨터를 켜면 곧바로 사용자의 시스템을 쓸 수 있었습니다. 여기에 하드디스크 부트섹터를 조작해서, 패스워드 인증프로그램을 거쳐야
       정상 부트과정을 이어가는 프로그램을 만들어 하이텔에 공개했습니다. """
    , Project "발표"
        2017
        "한글 코딩 도구 비지니스 피칭"
        (Just "https://medium.com/happyprogrammer-in-jeju/한글-코딩-도구-비지니스-피칭-a7727fd99663")
        "개인"
        [ "Clojure" ]
        """한글로 코딩하는 언어와 웹플랫폼을 만들어 코딩교육에 활용해보자는 사업화 아이디어를
       **제주창조경제혁신센터**에서 발표했습니다. 심사위원들로부터, 스크래치와 실무자용 언어 사이의 중고등학교용
       프로그래밍 언어로 공략하면 유효하겠다는 평가를 받았습니다. 슬라이드 내용은 제목 링크 참조."""
    , Project "발표"
        2016
        "PyCon 라이트닝토크 - 한글코딩 5분 발표"
        (Just "https://youtu.be/46UkzB-3z3Y")
        "개인"
        [ "Python", "Clojure" ]
        """한글코딩.org 사이트의 내용을 코믹 컨셉으로 파이콘 2016에서 발표했습니다. 파이콘 첫날 다른 사람들의 라이트닝토크 발표를 듣고
       동기부여받아서 즉흥적으로 준비해 둘째날 발표했고, 내용 자체 전달과 설득은 어떨지 몰라도, 적어도 웃음은 유발했습니다.
       [발표후기](https://medium.com/happyprogrammer-in-jeju/파이콘-2016-라이트닝-토크-발표-후기-763135a2a623)로도 정리했습니다.
       제목링크를 누르시면 발표영상을 보실 수 있습니다."""
    , Project "발표"
        2013
        "Daum DevOn 컨퍼런스 - 사내 Git 저장소 개발사례"
        (Just "https://www.slideshare.net/hatemogi/devon2013-git")
        "개인"
        [ "Git", "Ruby" ]
        """다음 사내 개발자용 Git 저장소 시스템을 개발했던 경험을 DevOn 컨퍼런스에서 발표했습니다.
       제목링크를 누르면 발표슬라이드를 보실 수 있습니다."""
    , Project "번역"
        2015
        "클로저 선문답 - Clojure Koans 한글 번역"
        (Just "https://clojurekoans.hatemogi.com")
        "개인"
        []
        """Clojure 프로그래밍 언어 기초 문법을 연습하는 내용의 웹페이지를 한국어로 번역해서 공개했습니다."""
    , Project "번역"
        2015
        "Ring - 클로저 웹서버 인터페이스 스펙 및 라이브러리 문서 번역"
        (Just "https://github.com/hatemogi/ring/wiki")
        "개인"
        []
        """클로저 프로그래밍 환경의 웹서비스 인터페이스인 Ring의 문서를 한국어로 번역했습니다. 클로저 Ring은 자바로 치자면 서블릿스펙과 비슷합니다."""
    , Project "번역"
        2014
        "유의미 버전 SemVer 한글 번역"
        (Just "https://semver.org/lang/ko")
        "개인"
        []
        """제품 버전 체계를 의미있게 잡아서 사용하자는 **Semantic Versioning** 스펙 문서를 한국어로 번역했습니다."""
    ]


tags =
    data
        |> List.concatMap .tags
        |> List.map String.toLower
        |> Set.fromList
        |> Set.toList
