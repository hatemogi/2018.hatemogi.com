import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type Section = S소개 | S프로젝트
type alias Model = { section : Section }

model : Model
model =
  { section = S소개 }


-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model

    Decrement ->
      model


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "columns" ]
    [ div [ class "column" ]
      [ button [ class "btn", onClick Decrement ] [ text "-" ]
      , text (toString model)
      , button [ class "btn", onClick Increment ] [ text "+" ]]
    , div [ class "column" ]
      [text "메인"]
    ]
