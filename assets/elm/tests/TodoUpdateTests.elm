module TodoUpdateTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html.Attributes as Attr
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, class, tag, text)
import Todo exposing (..)


initialModel =
    Todo.initialModel "a server url"


modelWithOneTodo =
    { serverUrl = "a server url", todos = [ { content = "1st to do" } ], clearNewTodo = True, newTodoContent = "" }


modelWithTwoTodos =
    { serverUrl = "a server url", todos = [ { content = "2nd to do" }, { content = "1st to do" } ], clearNewTodo = True, newTodoContent = "" }


suite : Test
suite =
    describe "Todo module"
        [ describe "Todo.update"
            -- Nest as many descriptions as you like.
            [ test "add 1 new todo" <|
                \_ ->
                    initialModel
                        |> Todo.update (Input "1st to do")
                        |> Tuple.first
                        |> Todo.update AddTodo
                        |> Tuple.first
                        |> Expect.equal modelWithOneTodo
            , test "add 2 new todo" <|
                \_ ->
                    initialModel
                        |> Todo.update (Input "1st to do")
                        |> Tuple.first
                        |> Todo.update AddTodo
                        |> Tuple.first
                        |> Todo.update (Input "2nd to do")
                        |> Tuple.first
                        |> Todo.update AddTodo
                        |> Tuple.first
                        |> Expect.equal modelWithTwoTodos
            ]
        ]
