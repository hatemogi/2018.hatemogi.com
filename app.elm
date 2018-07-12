import Html exposing (Html, button, nav, div, ul, li, p, a, i,
                      text, aside, main_, section, footer)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, classList)
import Http
import Markdown
import Xml.Decode

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

type Msg = Increment | Decrement |
           Go Section |
           MediumFeed (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model, Cmd.none)

    Decrement ->
      (model, Cmd.none)

    Go section ->
      ({model | section = section}, Cmd.none)

    MediumFeed (Ok content) ->
      ({model | medium = Just content}, Cmd.none)

    MediumFeed (Err _) ->
      ({model | medium = Nothing}, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [menuView model, mainView model, footerView model]

menuView : Model -> Html Msg
menuView model =
  let
    menu section label =
      li [ classList [("is-active", model.section == section)] ]
         [ a [onClick (Go section)] [ text label ]]
  in
    nav [ class "container" ]
      [ div [ class "tabs" ]
        [ ul []
          [ menu S소개 "소개"
          , menu S프로젝트 "프로젝트"
          , menu S잡담 "잡담" ]]]

introView : Html Msg
introView =
  div []
    [text
    """소프트웨어 개발자.
    어려서 Apple IIe로 독학 프로그래밍에 빠져든 이래 개발을 취미이자
    직업으로 삼았습니다. 홍익대에서 컴퓨터공학을 전공하고,
    다음커뮤니케이션(현: 카카오)에서 클라우드기술팀 팀장을 거치며 만 10년
    정도 근무한 뒤 퇴사하여, 1인 소프트웨어 개발사의 대표로 지내고 있습니다."""]

projectsView : Html Msg
projectsView =
  div [] [text "프로젝트"]

writingsView : Html Msg
writingsView =
  div [] [text "잡담"]

mainView : Model -> Html Msg
mainView model =
  main_ []
    (case model.section of
      S소개 ->
        [introView]
      S프로젝트 ->
        [projectsView]
      S잡담 ->
        [writingsView])

footerView : Model -> Html Msg
footerView model =
  footer [ class "footer" ]
    [ div [ class "content has-text-centered" ]
      [ p [] [ text "Copyright 2018 "
             , i [ class "fab fa-medium fa-lg" ] [] ]]]

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
