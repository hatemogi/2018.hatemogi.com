import Html exposing (Html, button, nav, div, ul, li, p, a, i,
                      text, aside, main_, section, footer)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, classList)
import Http
import Markdown

main =
  Html.program { init = init "테스트", view = view,
                 update = update, subscriptions = subscriptions }

-- MODEL

type Section = S소개 | S프로젝트 | S잡담
type alias Model = { section : Section, md : String }

init : String -> (Model, Cmd Msg)
init name =
  ({ section = S소개, md = "" }, loadMarkdown "README.md")

-- UPDATE

type Msg = Increment | Decrement |
           Go Section | Got (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model, Cmd.none)

    Decrement ->
      (model, Cmd.none)

    Go section ->
      ({model | section = section}, loadMarkdown "README.md")

    Got (Ok content) ->
      ({model | md = content}, Cmd.none)

    Got (Err _) ->
      (model, Cmd.none)

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

mainView : Model -> Html Msg
mainView model =
  main_ []
    [Markdown.toHtml [] model.md]

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

loadMarkdown : String -> Cmd Msg
loadMarkdown name =
  Http.send Got (Http.getString name)
