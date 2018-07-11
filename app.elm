import Html exposing (Html, button, nav, div, ul, li, p, a, i,
                      text, aside, main_, section, footer)
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
   [ text "body area" ]

footerView : Model -> Html Msg
footerView model =
  footer [ class "footer" ]
    [ div [ class "content has-text-centered" ]
      [ p [] [ text "Copyright 2018 "
             , i [ class "fab fa-medium fa-lg" ] [] ]]]
