import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Http
import Markdown
import Xml.Decode
import Projects

main =
  Html.program { init = init "테스트", view = view,
                 update = update, subscriptions = subscriptions }

-- MODEL

type Section = S소개 | S프로젝트 | S잡담
type alias Model = { section : Section, medium : Maybe String }

init : String -> (Model, Cmd Msg)
init name =
  ({ section = S소개, medium = Nothing }, loadMediumFeed)

-- UPDATE

type Msg = Go Section |
           MediumFeed (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Go section ->
      ({model | section = section}, Cmd.none)

    MediumFeed (Ok content) ->
      ({model | medium = Just content}, Cmd.none)

    MediumFeed (Err _) ->
      ({model | medium = Nothing}, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  section [ class "section is-info is-fullheight"]
    [ div [ class "container"] [ mainView model ]
    , div [ class "hero-foot" ] [footerView model ]]

menuView : Model -> Html Msg
menuView model =
  header [ class "navbar" ]
    [ div [ class "container" ] [] ]

mainView : Model -> Html Msg
mainView model =
  div [ class "has-text-centered columns"]
    [ div [ class "column box is-narrow" ] [ introCardView ]
    , div [ class "column box has-text-justified" ]
      [ div []
        (case model.section of
          S소개 ->
            [h1 [ class "title" ] [ text "김대현" ], introView]
          S프로젝트 ->
            [h1 [ class "title" ] [ text "프로젝트" ], projectsView]
          S잡담 ->
            [h1 [ class "title" ] [ text "잡담" ], writingsView])]]

footerView : Model -> Html Msg
footerView model =
  let
    menu section label =
      li [ classList [("is-active", model.section == section)]]
         [a [onClick (Go section)] [ text label ]]
  in
    nav [ class "tabs is-boxed is-fullwidth" ]
      [ div [ class "container" ]
        [ ul []
          [ menu S소개 "소개"
          , menu S프로젝트 "프로젝트"
          , menu S잡담 "잡담"]]]

introView : Html Msg
introView =
  markdown
    """소프트웨어 개발자.
어려서 재미삼아 프로그래밍에 빠져든 이래 개발을 취미이자
직업으로 삼았습니다. 홍익대에서 컴퓨터공학을 전공하고,
다음커뮤니케이션(현: 카카오)에서 클라우드기술팀 팀장을 거치며 만 10년
정도 근무한 뒤 퇴사하여, 1인 소프트웨어 개발사의 대표로 지내고 있습니다.
"""

projectsView : Html Msg
projectsView =
  let
    entryf : Projects.Project -> Html Msg
    entryf p =
      div [] [(h3 [] [text (toString p.year)]), text p.title]
  in
    div []
      ([ h1 [ class "title" ] [ text "프로젝트" ] ]
      ++ (List.map entryf Projects.data))

writingsView : Html Msg
writingsView =
  div [] [text "잡담"]

introCardView : Html Msg
introCardView =
  div [ class "card", style [("width", "230px")] ]
    [ div [ class "card-image" ] [img [src "img/profile.jpg"] []]
    , div [ class "card-content has-text-left" ]
        [markdown
         """백엔드 개발자. **이상적 Clojure**와 **현실적 Java**를 오가며 **실용 프로그래밍**.
            개발에 몰입할 때가 가장 즐거운 걸 보면 아무래도 **백발 개발자**가 될 모양새."""]
    , footer [ class "card-footer" ]
      [ p [ class "card-footer-item" ]
       [span [] [ a [ href "https://medium.com/happyprogrammer-in-jeju"]
                    [ i [ class "fab fa-medium fa-lg"] []
                    , text " 둘러보기"]]]]]

markdown : String -> Html Msg
markdown content =
  div [] [Markdown.toHtml [] content]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HTTP

loadMediumFeed : Cmd Msg
loadMediumFeed =
  -- CORS 해결 필요
  -- Http.send MediumFeed (Http.getString "https://medium.com/feed/happyprogrammer-in-jeju")
  Cmd.none
