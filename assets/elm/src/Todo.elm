module Todo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Todo =
    { content : String }


type alias Model =
    { serverUrl : String
    , todos : List Todo
    }


initialModel : String -> Model
initialModel serverUrl =
    { serverUrl = serverUrl, todos = [] }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        model =
            initialModel flags.serverUrl
    in
    ( model, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW

viewTodo: Todo -> Html Msg
viewTodo todo =
  div [class "todo"]
       [text todo.content]

viewTodos: List Todo -> Html Msg
viewTodos todos =
  div [ class "todo-lists"]
        (List.map viewTodo todos)

view : Model -> Html Msg
view model =
    div [ id "todo-app" ]
        [ input
            [ class "new-task"
            , placeholder "Add a task..."
            , autofocus True
            ]
            []
        , viewTodos model.todos
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
        , subscriptions = \_ -> Sub.none
        }
