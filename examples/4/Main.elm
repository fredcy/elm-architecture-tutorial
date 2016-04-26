
import CounterList exposing (init, update, view)
import Html.App exposing (beginnerProgram)


main =
  beginnerProgram
    { model = init
    , update = update
    , view = view
    }
