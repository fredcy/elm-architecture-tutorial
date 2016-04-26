module CounterList exposing (..)

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as Html


-- MODEL

type alias Model =
    { counters : List ( ID, Counter.Model )
    , nextID : ID
    }

type alias ID = Int


init : Model
init =
    { counters = []
    , nextID = 0
    }


-- UPDATE

type Action
    = Insert
    | Remove ID
    | Modify ID Counter.Message


update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
      { model |
          counters = ( model.nextID, Counter.init 0 ) :: model.counters,
          nextID = model.nextID + 1
      }

    Remove id ->
      { model |
          counters = List.filter (\(counterID, _) -> counterID /= id) model.counters
      }

    Modify id counterAction ->
      let updateCounter (counterID, counterModel) =
              if counterID == id then
                case counterAction of
                  Counter.Local localAction ->
                    Just (counterID, Counter.update localAction counterModel)
                  Counter.Remove ->
                    Nothing
              else
                Just (counterID, counterModel)
      in
          { model | counters = List.filterMap updateCounter model.counters }


-- VIEW

view : Model -> Html Action
view model =
  let insert = button [ onClick Insert ] [ text "Add" ]
  in
      div [] (insert :: List.map (viewCounter) model.counters)


viewCounter : (ID, Counter.Model) -> Html Action
viewCounter (id, model) =
  Counter.viewWithRemoveButton model |> Html.map (Modify id)
    
