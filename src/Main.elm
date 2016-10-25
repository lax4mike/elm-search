module Main exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Tree exposing (..)


-- MODEL


type alias Model =
    Tree


model : Model
model =
    (addChildren (createNode "A")
        [ (addChildren (createNode "B") [ (createNode "D"), (createNode "E") ])
        , (createNode "X")
        , (addChildren (createNode "C") [ (createNode "F") ])
        ]
    )

bfsLog : List String
bfsLog = (Debug.log "bfs" (Tree.bfs model))

dfsLog : List String
dfsLog = (Debug.log "dfs" (Tree.dfs model))

-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    Tree
        { label = "fake"
        , children = []
        }



-- VIEW


treeView : Tree -> Html Msg
treeView tree =
    case tree of
        Tree tree ->
            ul []
                [ li []
                    (List.append
                        [ (text tree.label) ]
                        (List.map treeView tree.children)
                    )
                ]


view : Model -> Html Msg
view model =
    div [ style [ ( "padding", "10px" ) ] ]
        [ (treeView model)
        ]



-- MAIN


main : Program Never
main =
    Html.App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
