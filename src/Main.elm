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
    (createNode 1
        "One"
        [ (createNode 2
            "Two"
            [ (createNode 5 "Five" [])
            , (createNode 6 "Six" [])
            ]
          )
        , (createNode 3
            "Three"
            [ (createNode 7 "Seven" [])
            , (createNode 8 "Eight" [])
            , (createNode 9 "Nine" [])
            ]
          )
        , (createNode 4
            "Four"
            [ (createNode 10 "Ten" [])
            , (createNode 11 "Eleven" [])
            ]
          )
        ]
    )


bfsLog : List String
bfsLog =
    (Debug.log "bfs" (Tree.bfsLog model))


dfsLog : List String
dfsLog =
    (Debug.log "dfs" (Tree.dfsLog model))


dfsFindTest : Maybe Tree
dfsFindTest =
    (Debug.log "dfsFindTest found" (Tree.dfsFind model (Tree.idIs 9)))


bfsFindTest : Maybe Tree
bfsFindTest =
    (Debug.log "bfsFindTest" (Tree.bfsFind model (Tree.idIs 9)))



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    Tree
        { id = 0
        , label = "fake"
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
