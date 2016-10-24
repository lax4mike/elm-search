import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Tree exposing (..)



-- MODEL

type alias Model = Tree
model : Model
model =
  (addChildren (createNode "A") [
      (createNode "B"),
      (addChildren (createNode "C") [ (createNode "D") ]),
      (createNode "E")
    ]
  )


-- UPDATE

type Msg
  = NoOp

update: Msg -> Model -> Model
update msg model =
  Empty

-- VIEW

graphView : Tree -> Html Msg
graphView tree =
  case tree of
    Tree tree ->
      ul [] [
        li []
          (List.append
            [(text tree.label)]
            (List.map graphView tree.children)
          )
          -- (List.map (\c -> graphView c) node.children))
      ]
    Empty -> (text "empty!")

view : Model -> Html Msg
view model =
  div [ style [("padding", "10px")]] [
    (graphView model)
  ]


-- MAIN

main : Program Never
main =
  Html.App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
