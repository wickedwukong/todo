module TodoTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag, class)

import Todo exposing(..)


suite : Test
suite =
    describe "Todo module"
        [ describe "Todo.view" -- Nest as many descriptions as you like.
            [ test "start with no todo lists" <|
                \_ ->
                  let
                    emptyToDoLists = {serverUrl = "a server url"}
                  in
                   emptyToDoLists
                     |> Todo.view
                     |> Query.fromHtml
                     |> Query.find [ tag "input"]
                     |> Query.has [ class "new-task"]

            -- Expect.equal is designed to be used in pipeline style, like this.
            , test "reverses a known string" <|
                \_ ->
                    "ABCDEFG"
                        |> String.reverse
                        |> Expect.equal "GFEDCBA"

            -- fuzz runs the test 100 times with randomly-generated inputs!
            , fuzz string "restores the original string if you run it again" <|
                \randomlyGeneratedString ->
                    randomlyGeneratedString
                        |> String.reverse
                        |> String.reverse
                        |> Expect.equal randomlyGeneratedString
            ]
        ]
