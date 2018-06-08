import Elm from "./todo"

const todoContainer = document.getElementById("todo-container")

if (todoContainer) {
  Elm.Todo.embed(todoContainer, {
    serverUrl: todoContainer.getAttribute("data-server-url-name"),
  })
}
