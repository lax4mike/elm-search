import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)

type Children = Children (List Node) | Empty
type alias Node = { value: Int, children: Children }

myGraph : Node
myGraph = Node 1 (Children [
    Node 2 (Children [
        Node 3 Empty,
        Node 4 Empty
    ])
 ])

-- MODEL

type alias Model = String
model : Model
model =
  "Sarah"


-- UPDATE

type Msg
  = NoOp

update: Msg -> Model -> Model
update msg model =
  ""

-- VIEW

-- graphView : Node -> Html Msg
-- graphView node =
--   ul [] [
--     li [] (List.append
--       [ text (toString node.value)]
--       (List.map (\c -> graphView c) node.children)
--     )
--   ]

view : Model -> Html Msg
view model =
  div [ style [("padding", "10px")]] [
    -- (graphView myGraph)
    text (toString myGraph)
  ]


-- MAIN

main : Program Never
main =
  Html.App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
