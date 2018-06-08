module Todo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


-- MODEL


type alias Todo =
    { content : String }


type alias Model =
    { serverUrl : String
    , todos : List Todo
    , clearNewTodo : Bool
    , newTodoContent : String
    }


initialModel : String -> Model
initialModel serverUrl =
    { serverUrl = serverUrl, todos = [], clearNewTodo = False, newTodoContent = "" }


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
    | AddTodo
    | Input String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        AddTodo ->
            ( { model | todos = { content = model.newTodoContent } :: model.todos, clearNewTodo = True, newTodoContent = "" }, Cmd.none )

        Input newInput ->
            ( { model | newTodoContent = newInput }, Cmd.none )



-- VIEW


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
    on "keydown" (Json.andThen isEnter keyCode)


viewTodo : Todo -> Html Msg
viewTodo todo =
    div [ class "todo" ]
        [ text todo.content ]


viewTodos : List Todo -> Html Msg
viewTodos todos =
    div [ id "todos" ]
        (List.map viewTodo todos)


view : Model -> Html Msg
view model =
    let
        inputValue =
            if model.clearNewTodo then
                ""
            else
                model.newTodoContent
    in
    div [ id "todo-app" ]
        [ input
            [ class "new-task"
            , placeholder "Add a task..."
            , autofocus True
            , onEnter AddTodo
            , onInput Input
            , value inputValue
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
