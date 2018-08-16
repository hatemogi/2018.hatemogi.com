import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Http
import Markdown
import Xml.Decode
import Projects
import Intro
import Dict
import Set

main =
  Html.program { init = init "테스트", view = view,
                 update = update, subscriptions = subscriptions }

-- MODEL

type Section = S소개 | S프로젝트 | S글 | S잡담
type alias Model =
  { section : Section
  , projectFilter: Maybe String
  , medium : Maybe String }

init : String -> (Model, Cmd Msg)
init name =
  ({ section = S프로젝트, medium = Nothing, projectFilter = Nothing }, loadMediumFeed)

-- UPDATE

type Msg = Go Section |
           MediumFeed (Result Http.Error String) |
           ProjectFilter (Maybe String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Go section ->
      ({model | section = section}, Cmd.none)

    MediumFeed (Ok content) ->
      ({model | medium = Just content}, Cmd.none)

    MediumFeed (Err _) ->
      ({model | medium = Nothing}, Cmd.none)

    ProjectFilter filter ->
      ({model | projectFilter = filter}, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div [ class "wrap" ]
    [ menuView model
    , mainView model
    , footerView model ]

menuView : Model -> Html Msg
menuView model =
  let
    menu section (icon, label) =
      li [ classList [("is-active", model.section == section)]]
         [a [onClick (Go section)] [span [class "icon is-small"] [i [class ("fas " ++ icon)] []], span [] [text label] ]]
  in
    nav [ class "tabs is-boxed is-fullwidth" ]
      [ div [ class "container" ]
        [ ul []
          [ menu S소개 ("fa-user-circle", "소개")
          , menu S프로젝트 ("fa-file-code", "프로젝트")
--          , menu S글 ("fa-edit", "글")
--          , menu S잡담 ("fa-comment", "잡담")
          ]]]

mainView : Model -> Html Msg
mainView model =
 div [ class "container" ]
   [ div [ class "has-text-centered columns"]
      [ div [ class "column is-narrow" ] [ profileView ]
      , main_ [ class "column has-text-justified" ]
          [ div []
              (case model.section of
                 S소개     -> [h1 [ class "title" ] [ text "김대현" ], introView]
                 S프로젝트 -> [h1 [ class "title" ] [ text "프로젝트" ], projectsView model.projectFilter]
                 S글       -> [h1 [ class "title" ] [ text "글" ], projectsView model.projectFilter]
                 S잡담     -> [h1 [ class "title" ] [ text "잡담" ], writingsView])]]]

footerView : Model -> Html Msg
footerView model =
  footer [ class "footer" ]
    [ div [ class "content has-text-centered" ]
          [ p [] [ text "hatemogi.com" ]
          , markdown """Source code licensed [MIT](https://opensource.org/licenses/mit-license.php)<br/>
Website content licensed [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)""" ] ]

profileView : Html Msg
profileView =
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
                    , text " 미디엄 보기"]]]]]

introView : Html Msg
introView =
  markdown
    """소프트웨어 개발자.
어려서 재미삼아 프로그래밍에 빠져든 이래 개발을 취미이자
직업으로 삼았습니다. 홍익대에서 컴퓨터공학을 전공하고,
다음커뮤니케이션(현재 카카오)에서 클라우드기술팀 팀장을 거치며 만 10년
정도 근무한 뒤, 지금은 1인 소프트웨어 개발사의 대표로 지내고 있습니다.

## 다음 커뮤니케이션

다음커뮤니케이션에서는 카페, 플래닛, 캘린더, 마이피플등의 서비스 개발에
참여했고, 간혹 웹 프론트엔드나 iOS앱 개발도 했지만, 대부분은 Java와 Ruby로
백엔드 웹서비스를 개발했습니다.

## 오후코드 (개인 개발자)

개인 소프트웨어 개발사 대표로 외주계약 개발자로 일하며, 두 주요 고객사를
위한 서버 소프트웨어를 개발해 납품했습니다.


"""

projectsView : (Maybe String) -> Html Msg
projectsView filter =
  let
    categoryColor: String -> String
    categoryColor cat =
      case cat of
        "업무" -> "is-warning"
        "취미" -> "is-info"
        "발표" -> "is-success"
        "번역" -> "is-primary"
        "전체" -> "is-link"
        _ -> ""
    entryf : Projects.Project -> Html Msg
    entryf p =
      article [class "media"]
              [div [class "media-left"]
                   [div [class "tags has-addons"]
                        [span [class "tag"] [text (toString p.year)]
                        ,span [class ("tag " ++ (categoryColor p.category))] [text p.category]]]
              ,div [class "media-content"]
                 [Html.p []
                   [div [class "content"]
                     [strong []
                       [case p.url of
                         Nothing  -> text p.title
                         Just url -> a [href url] [text p.title, span [class "icon"] [i [class "fas fa-link fa-sm"] []]]]
                     , markdown p.description]
                 ,div [class "tags"] (List.map (\t -> span [class "tag is-success"] [text t]) p.tags)]]]
    button : String -> Html Msg
    button category =
      case filter of
        Just cat ->
          span [ class ("button " ++ (if category == cat then (categoryColor cat) else ""))
               , onClick (ProjectFilter (if category == "전체" then Nothing else Just category))]
               [text category]
        Nothing ->
          span [ class ("button " ++ (if category == "전체" then "is-link" else ""))
               , onClick (ProjectFilter (if category == "전체" then Nothing else Just category))]
               [text category]
  in
    div []
      [div [class "buttons has-addons"]
           [button "전체"
           ,button "업무"
           ,button "취미"
           ,button "발표"
           ,button "번역"]
      ,div [] (Projects.data
               |> List.filter (\p -> case filter of
                                       Just f -> p.category == f
                                       Nothing -> True)
               |> List.sortBy (\p -> -p.year)
               |> List.map entryf)]

writingsView : Html Msg
writingsView =
  div [] [text "잡담"]

markdown : String -> Html Msg
markdown content =
  Markdown.toHtml [] content

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
