module TodoTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html.Attributes as Attr
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, class, tag, text)
import Todo exposing (..)


initialModel =
    { serverUrl = "a server url", todos = [] }


modelWithTodos =
    { serverUrl = "a server url"
    , todos =
        [ { content = "1st to do" }
        , { content = "2nd to do" }
        ]
    }


suite : Test
suite =
    describe "Todo module"
        [ describe "Todo.view"
            -- Nest as many descriptions as you like.
            [ test "start with no todo lists" <|
                \_ ->
                    let
                        all =
                            [ attribute <| Attr.placeholder "Add a task..."
                            , class "new-task"
                            , attribute <| Attr.autofocus True
                            ]
                    in
                    initialModel
                        |> Todo.view
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Query.has all

            -- Expect.equal is designed to be used in pipeline style, like this.
            , test "display a list of to dos" <|
                \_ ->
                    modelWithTodos
                        |> Todo.view
                        |> Query.fromHtml
                        |> Query.findAll [ class "todo" ]
                        |> Query.count (Expect.equal 2)
            , test "display 1st todo content" <|
                \_ ->
                    modelWithTodos
                        |> Todo.view
                        |> Query.fromHtml
                        |> Query.findAll [ class "todo" ]
                        |> Query.first
                        |> Query.has [ text "1st to do" ]
            , test "display 2nd todo content" <|
                \_ ->
                    modelWithTodos
                        |> Todo.view
                        |> Query.fromHtml
                        |> Query.findAll [ class "todo" ]
                        |> Query.index 1
                        |> Query.has [ text "2nd to do" ]

            -- fuzz runs the test 100 times with randomly-generated inputs!
            , fuzz string "restores the original string if you run it again" <|
                \randomlyGeneratedString ->
                    randomlyGeneratedString
                        |> String.reverse
                        |> String.reverse
                        |> Expect.equal randomlyGeneratedString
            ]
        ]
