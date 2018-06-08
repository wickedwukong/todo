module Todo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    { serverUrl : String }


initialModel : String -> Model
initialModel serverUrl =
    { serverUrl = serverUrl }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        model = initialModel flags.serverUrl
    in
    ( model, Cmd.none)


-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


-- VIEW


view : Model -> Html Msg
view model =
  div [ id "to-do-lists"]
      [ input [ class "new-task"
              , placeholder "Add a task..."
              , autofocus True
              ]
              []
      ]
    -- MAIN


type alias Flags =
    { serverUrl : String }

main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none )
        }
