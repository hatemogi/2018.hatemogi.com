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
  ({ section = S소개, medium = Nothing, projectFilter = Nothing }, loadMediumFeed)

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
                        Website content licensed [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)"""
          , p [] [markdown """This site is created with Elm, Bulma, and FontAwesome.""" ]]]

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
  let
    sectionf : Intro.Section -> Html Msg
    sectionf section =
      article [class "media"]
        [div [class "media-content"]
          [h2 [] [text section.title]
          ,markdown section.description]]
  in
    div []
      ((List.map sectionf Intro.data)
      ++
      [div [class "media"]
        [button [class "button is-primary", onClick (Go S프로젝트)] [text "프로젝트 보기"]]])

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
      [article [class "message"]
        [div [class "message-body"]
          [markdown
            """제가 참여했던 프로젝트를 일일이 열거했습니다. 대부분 사소한 프로젝트들이라 애써 설명드릴만한 내용은 없지만,
               저 스스로 어떤 일들을 해왔는지 참고로, 앞으로 할 일들을 고민해보려 합니다.
               만약 그럴싸한 프로젝트가 있다면, 훌륭한 동료들이 하는 일에 작은 역할로 참여했던 것이고,
               대부분 사소한 프로젝트는 제가 단독으로 진행한 것들일 겁니다."""
          ,markdown
            """직업적으로 한일은 **업무**, 개인적 호기심으로 진행한 일은 **취미**, 외부 공개로 발표한 내용은 **발표**,
               영문 문서를 한국어로 번역한 작업은 **번역**으로 꼬리표를 달았으며, 아래 탭을 누르면 추려서 보실 수 있습니다."""]]
      ,div [class "buttons has-addons"]
           [button "전체", button "업무", button "취미", button "발표", button "번역"]
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
