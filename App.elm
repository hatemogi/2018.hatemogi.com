import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Http
import Markdown
import Xml.Decode
import Intro
import Projects
import Article
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
  div []
    [div [ class "wrap" ]
      [ menuView model
      , mainView model ]
    , footerView model ]

menuView : Model -> Html Msg
menuView model =
  let
    menu section (icon, label) =
      li [ classList [("is-active", model.section == section)]]
         [a [onClick (Go section)]
           [span [class "icon is-small"] [i [class "fas", class icon] []], span [] [text label] ]]
  in
    nav [ class "tabs is-boxed is-medium is-fullwidth" ]
        [ ul []
          [ menu S소개 ("fa-user-circle", "소개")
          , menu S프로젝트 ("fa-file-code", "프로젝트")
          , menu S글 ("fa-edit", "글")
--          , menu S잡담 ("fa-comment", "잡담")
        ]]

mainView : Model -> Html Msg
mainView model =
  let
    titlef : String -> Html Msg -> List (Html Msg)
    titlef title content =
      [h1 [ class "title" ] [ text title ], content]
  in
    div [ class "container" ]
      [ div [ class "columns is-centered"]
         [ div [ class "column is-narrow is-hidden-mobile" ] [profileView]
         , main_ [ class "column has-text-justified" ]
                (case model.section of
                   S소개     -> titlef "김대현" introView
                   S프로젝트 -> titlef "프로젝트" (projectsView model.projectFilter)
                   S글       -> titlef "글" (articlesView model)
                   S잡담     -> titlef "잡담" (rantsView model)) ]]

footerView : Model -> Html Msg
footerView model =
  footer [ class "footer" ]
    [ div [ class "content has-text-justified" ]
          [ p [] [ text "hatemogi.com" ]
          , markdown """이 사이트를 만든 [소스코드](https://github.com/hatemogi/2018.hatemogi.com)는
                        [MIT 라이선스](https://opensource.org/licenses/mit-license.php)를 따릅니다. <br/>
                        그리고, 여기 적은 글은 [CC BY-NC-SA 4.0 라이선스](https://creativecommons.org/licenses/by-nc-sa/4.0/)를 따릅니다."""
          , p [] [markdown """이 웹사이트는 Elm, Bulma, FontAwesome를 써서 만들었습니다.""" ]]]

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
      ++ [div [class "media"]
           [button [class "button is-info", onClick (Go S프로젝트)] [text "프로젝트 보기"]]])

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
                        ,span [class "tag", class (categoryColor p.category)] [text p.category]]]
              ,div [class "media-content"]
                 [Html.p []
                   [div [class "content"]
                     [strong []
                       [case p.url of
                         Nothing  -> text p.title
                         Just url -> a [href url] [text p.title, span [class "icon"] [i [class "fas fa-link fa-sm"] []]]]
                     , markdown p.description]
                 ,div [class "tags"] (List.map (\t -> span [class "tag"] [text t]) p.tags)]]]
    button : String -> Html Msg
    button category =
      case filter of
        Just cat ->
          span [ class "button"
               , class (if category == cat then (categoryColor cat) else "")
               , onClick (ProjectFilter (if category == "전체" then Nothing else Just category))]
               [text category]
        Nothing ->
          span [ class "button"
               , class (if category == "전체" then "is-link" else "")
               , onClick (ProjectFilter (if category == "전체" then Nothing else Just category))]
               [text category]
  in
    div []
      [article [class "message"]
        [div [class "message-body"]
          [markdown
            """아래 일일이 열거한 것은 대부분 사소한 프로젝트들이라 애써 설명드릴만한 내용은 없지만,
               저 스스로 어떤 일들을 해왔는지 참고해서 앞으로 할 일들을 고민해보려 합니다.
               만약 그럴듯한 프로젝트가 있다면, 훌륭한 동료들이 하는 일에 작은 역할로 참여했던 것이고,
               나머지 대부분 사소한 프로젝트는 제가 단독으로 진행한 것들일 겁니다."""
            ]]
      ,div [class "buttons has-addons"]
           [button "전체", button "업무", button "취미", button "발표", button "번역"]
      ,div [] (Projects.data
               |> List.filter (\p -> case filter of
                                       Just f -> p.category == f
                                       Nothing -> True)
               |> List.sortBy (\p -> -p.year)
               |> List.map entryf)]

articlesView : Model -> Html Msg
articlesView model =
  let
    articlef : Article.Article -> Html Msg
    articlef a =
      article [class "media"]
        [div [class "media-content"]
          [Html.a [href a.url] [strong [] [text a.title], span [class "icon"] [i [class "fas fa-link fa-sm"] []]]
          , markdown a.summary]]
  in
    div []
      [article [class "message"]
        [div [class "message-body"]
          [markdown
            """부족하나마 나름의 생각을 정리한 글들을 주로 [미디엄](https://medium.com/happyprogrammer-in-jeju)에 올리고 있습니다.
               아래에 그 중 반응이 좋았거나, 제가 더 알리고 싶다고 생각하는 글을 몇 편 골라두었습니다."""
          ]]
      , div [] (Article.data |> List.map articlef)]

rantsView : Model -> Html Msg
rantsView model =
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
