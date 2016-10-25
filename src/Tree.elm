module Tree exposing (..)

type Tree = Tree { label: String, children: List Tree }

-- type Children = Children (List Tree) | Empty
-- type alias Tree = { label: Int, children: Children }

getLabel : Tree -> String
getLabel tree =
  case tree of Tree tree -> tree.label


createNode : String -> Tree
createNode label =
  Tree { label = label, children = [] }


addChild : Tree -> Tree -> Tree
addChild tree child =
  case tree of
    Tree tree ->
      Tree { tree | children = child :: tree.children }


addChildren : Tree -> List Tree -> Tree
addChildren tree children =
  case tree of
    Tree tree ->
      Tree { tree | children = (List.append tree.children children) }


-- depth-first search
dfs : Tree -> List String
dfs tree =
  case tree of
    Tree tree ->
      List.concat
        [ [tree.label]
        , List.concatMap dfs tree.children
        ]


-- breadth-first search
bfs : Tree -> List String
bfs tree =
  case tree of
    Tree tree ->
      let
        -- record this tree's label and it's children
        visited = (tree.label) :: List.map getLabel tree.children

        -- a function to determine if a label is already in the visited list
        isNotInVisited : String -> Bool
        isNotInVisited label =
          not (List.member label visited)

        -- recurse for each child, and filter out visited nodes
        newNodes =
          List.filter isNotInVisited (List.concatMap bfs tree.children)
      in
        List.append visited newNodes
