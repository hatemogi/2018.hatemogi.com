import Html exposing (Html, button, nav, div, ul, li, p, a, text, aside, main_, section, footer)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, classList)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type Section = S소개 | S프로젝트 | S잡담
type alias Model = { section : Section }

model : Model
model =
  { section = S소개 }

-- UPDATE

type Msg = Increment | Decrement | Go Section

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model

    Decrement ->
      model

    Go section ->
      {model | section = section}

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [menuView model, mainView model, footerView model]

menuView : Model -> Html Msg
menuView model =
  nav []
    [ div [ class "tabs" ]
      [ ul []
        [ li [ classList [("is-active", model.section == S소개)] ]
             [ a [ onClick (Go S소개)] [ text "소개" ]]
        , li [ classList [("is-active", model.section == S프로젝트)]]
             [ a [ onClick (Go S프로젝트)] [ text "프로젝트" ]]
        , li [ classList [("is-active", model.section == S잡담)]]
             [ a [ onClick (Go S잡담)] [ text "잡담" ]]]]]

mainView : Model -> Html Msg
mainView model =
  main_ []
   [ text "body area" ]

footerView : Model -> Html Msg
footerView model =
  footer [ class "footer" ]
    [ div [ class "content has-text-centered" ]
      [ p [] [ text "copyright 2018" ]]]
