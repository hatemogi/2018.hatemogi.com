import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model = Int

model : Model
model =
  0


-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1


-- VIEW

view : Model -> Html Msg
view model =
  Grid.container []
    [Grid.row []
      [ Grid.col []
        [ button [ class "btn", onClick Decrement ] [ text "-" ]
        , text (toString model)
        , button [ class "btn", onClick Increment ] [ text "+" ]]
      ]
    ]
