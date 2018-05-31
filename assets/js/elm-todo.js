import Elm from "./todo"

const todoContainer = document.getElementById("todo-container")

if (todoContainer) {
  Elm.Todo.embed(todoContainer)
}
