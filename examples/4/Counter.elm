module Counter exposing (Model, init, Action, Message(..), update, view, viewWithRemoveButton)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model = Int


init : Int -> Model
init count = count


-- UPDATE

type Action = Increment | Decrement

type Message = Local Action | Remove


update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      model + 1

    Decrement ->
      model - 1


-- VIEW

view : Model -> Html Message
view model =
  div []
    [ button [ onClick (Local Decrement) ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick (Local Increment) ] [ text "+" ]
    ]


viewWithRemoveButton : Model -> Html Message
viewWithRemoveButton model =
  div []
    [ button [ onClick (Local Decrement) ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick (Local Increment) ] [ text "+" ]
    , div [ countStyle ] []
    , button [ onClick Remove ] [ text "X" ]
    ]


countStyle : Attribute Message
countStyle =
  style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]
